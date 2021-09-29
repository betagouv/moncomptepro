import { parse as parseUrl } from 'url';
import { isEmpty } from 'lodash';

import notificationMessages from '../notificationMessages';
import {
  changePassword,
  login,
  sendEmailAddressVerificationEmail,
  sendResetPasswordEmail,
  signup,
  updatePersonalInformations,
  verifyEmail,
} from '../managers/user';
import { getOrganizationsByUserId } from '../managers/organization';
import { isUrlTrusted } from '../services/security';

// redirect user to login page if no active session is available
export const checkUserIsConnectedMiddleware = async (req, res, next) => {
  if (isEmpty(req.session.user) && req.method === 'GET') {
    const redirectPath = `${parseUrl(req.url).pathname}${
      parseUrl(req.url).search ? parseUrl(req.url).search : ''
    }`;
    return res.redirect(
      `/users/sign-in?referer=${encodeURIComponent(redirectPath)}`
    );
  }

  if (isEmpty(req.session.user)) {
    return next(new Error('user must be logged in to perform this action'));
  }

  return next();
};

export const checkUserIsVerifiedMiddleware = async (req, res, next) => {
  return checkUserIsConnectedMiddleware(req, res, () => {
    if (!req.session.user.email_verified) {
      return res.redirect(`/users/verify-email`);
    }

    return next();
  });
};

export const checkUserHasPersonalInformationsMiddleware = async (
  req,
  res,
  next
) => {
  return checkUserIsVerifiedMiddleware(req, res, async () => {
    const { given_name, family_name, phone_number, job } = req.session.user;
    if (
      isEmpty(given_name) ||
      isEmpty(family_name) ||
      isEmpty(phone_number) ||
      isEmpty(job)
    ) {
      return res.redirect('/users/personal-information');
    }

    return next();
  });
};

// check that user go through all requirements before issuing a session
export const checkUserSignInRequirementsMiddleware = async (req, res, next) => {
  return checkUserHasPersonalInformationsMiddleware(req, res, async () => {
    if (isEmpty(await getOrganizationsByUserId(req.session.user.id))) {
      return res.redirect('/users/join-organization');
    }

    return next();
  });
};

export const issueSessionOrRedirectController = async (req, res, next) => {
  if (req.session.interactionId) {
    return res.redirect(`/interaction/${req.session.interactionId}/login`);
  }

  if (req.body.referer && isUrlTrusted(req.body.referer)) {
    return res.redirect(req.body.referer);
  }

  return res.redirect('https://datapass.api.gouv.fr');
};

export const getSignInController = async (req, res, next) => {
  const notifications = notificationMessages[req.query.notification]
    ? [notificationMessages[req.query.notification]]
    : [];

  return res.render('sign-in', {
    notifications,
    referer: req.query.referer,
    csrfToken: req.csrfToken(),
  });
};

export const postSignInMiddleware = async (req, res, next) => {
  try {
    req.session.user = await login(req.body.login, req.body.password);

    next();
  } catch (error) {
    if (error.message === 'invalid_credentials') {
      const refererQueryParam = req.body.referer
        ? `&referer=${encodeURIComponent(req.body.referer)}`
        : '';

      return res.redirect(
        `/users/sign-in?notification=${error.message}${refererQueryParam}`
      );
    }

    next(error);
  }
};

export const getSignUpController = async (req, res, next) => {
  const notifications = notificationMessages[req.query.notification]
    ? [notificationMessages[req.query.notification]]
    : [];

  return res.render('sign-up', {
    notifications,
    csrfToken: req.csrfToken(),
    loginHint: req.query.login_hint,
    forceEmail: req.query.login_hint && req.query.force_email,
  });
};

export const postSignUpController = async (req, res, next) => {
  try {
    req.session.user = await signup(req.body.login, req.body.password);

    await sendEmailAddressVerificationEmail(req.session.user.email);

    next();
  } catch (error) {
    if (
      error.message === 'email_unavailable' ||
      error.message === 'invalid_email'
    ) {
      return res.redirect(`/users/sign-up?notification=${error.message}`);
    }
    if (error.message === 'weak_password') {
      return res.redirect(
        `/users/sign-up?notification=${error.message}&login_hint=${
          req.body.login
        }`
      );
    }

    next(error);
  }
};

export const getVerifyEmailController = async (req, res, next) => {
  const notifications = notificationMessages[req.query.notification]
    ? [notificationMessages[req.query.notification]]
    : [];

  return res.render('verify-email', {
    notifications,
    email: req.session.user.email,
    csrfToken: req.csrfToken(),
  });
};

export const postVerifyEmailController = async (req, res, next) => {
  try {
    const verifyEmailToken = req.body.verify_email_token;

    req.session.user = await verifyEmail(verifyEmailToken);

    next();
  } catch (error) {
    if (error.message === 'invalid_token') {
      return res.redirect(
        `/users/verify-email?notification=invalid_verify_email_code`
      );
    }

    next(error);
  }
};

export const postSendEmailVerificationController = async (req, res, next) => {
  try {
    await sendEmailAddressVerificationEmail(req.session.user.email);

    return res.redirect(
      `/users/verify-email?notification=email_verification_sent`
    );
  } catch (error) {
    if (error.message === 'email_verified_already') {
      return res.redirect(`/users/verify-email?notification=${error.message}`);
    }

    next(error);
  }
};

export const getResetPasswordController = async (req, res, next) => {
  const notifications = notificationMessages[req.query.notification]
    ? [notificationMessages[req.query.notification]]
    : [];

  return res.render('reset-password', {
    notifications,
    csrfToken: req.csrfToken(),
  });
};

export const postResetPasswordController = async (req, res, next) => {
  try {
    const login = req.body.login;

    await sendResetPasswordEmail(login);

    return res.redirect(
      `/users/sign-in?notification=reset_password_email_sent`
    );
  } catch (error) {
    next(error);
  }
};

export const getChangePasswordController = async (req, res, next) => {
  const resetPasswordToken = req.query.reset_password_token;

  const notifications = notificationMessages[req.query.notification]
    ? [notificationMessages[req.query.notification]]
    : [];

  return res.render('change-password', {
    resetPasswordToken,
    notifications,
    csrfToken: req.csrfToken(),
  });
};

export const postChangePasswordController = async (req, res, next) => {
  try {
    const resetPasswordToken = req.body.reset_password_token;

    if (req.body.password !== req.body.password_confirmation) {
      return res.redirect(
        `/users/change-password?reset_password_token=${resetPasswordToken}&notification=passwords_do_not_match`
      );
    }

    await changePassword(resetPasswordToken, req.body.password);

    return res.redirect(`/users/sign-in?notification=password_change_success`);
  } catch (error) {
    if (error.message === 'invalid_token') {
      return res.redirect(
        `/users/reset-password?notification=${error.message}`
      );
    }

    if (error.message === 'weak_password') {
      const resetPasswordToken = req.body.reset_password_token;

      return res.redirect(
        `/users/change-password?reset_password_token=${resetPasswordToken}&notification=${
          error.message
        }`
      );
    }

    next(error);
  }
};

export const getPersonalInformationsController = async (req, res, next) => {
  const notifications = notificationMessages[req.query.notification]
    ? [notificationMessages[req.query.notification]]
    : [];

  return res.render('personal-information', {
    given_name: req.session.user.given_name,
    family_name: req.session.user.family_name,
    phone_number: req.session.user.phone_number,
    job: req.session.user.job,
    notifications,
    csrfToken: req.csrfToken(),
  });
};

export const postPersonalInformationsController = async (req, res, next) => {
  try {
    const { given_name, family_name, phone_number, job } = req.body;

    req.session.user = await updatePersonalInformations(req.session.user.id, {
      given_name,
      family_name,
      phone_number,
      job,
    });

    next();
  } catch (error) {
    if (error.message === 'invalid_personal_informations') {
      return res.redirect(
        `/users/personal-information?notification=${error.message}`
      );
    }

    next(error);
  }
};

export const getHelpController = async (req, res, next) => {
  return res.render('help', {});
};
