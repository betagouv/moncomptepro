import ejs from "ejs";
import { Application, NextFunction, Request, Response } from "express";
import fs from "fs";
import path from "path";
import { NODE_ENV } from "../config/env";
import {
  getUserFromLoggedInSession,
  isWithinLoggedInSession,
} from "../managers/session";

let manifest: Record<
  string,
  {
    file: string;
    imports?: string[];
    isEntry?: boolean;
    src?: string;
  }
> | null = null;

const viteAssetPath = (name: string) => {
  // cache the manifest file only in production
  if (NODE_ENV !== "production" || manifest === null) {
    try {
      const data = fs.readFileSync(
        path.resolve(
          import.meta.dirname,
          "..",
          "..",
          "dist",
          ".vite",
          "manifest.json",
        ),
        "utf8",
      );
      manifest = JSON.parse(data);
    } catch (e) {
      manifest = null;
    }
  }
  const filename = `assets/${name}`;
  if (manifest === null || !manifest[filename]) {
    return filename;
  }

  return `/dist/${manifest[filename].file}`;
};

/**
 * take a css asset name located at the root of /assets/css
 * and returns the hashed version of it
 *
 * this is used as a helper function in EJS templates, usable via `<%= css('app.css') %>`
 *
 * @param name basename, ie 'app.css'
 * @returns hashed name with full public path of the file, ie '/dist/assets/app.5e486f4a.css`
 */
const viteCssPath = (name: string) => {
  return viteAssetPath(`css/${name}`);
};

/**
 * take a js asset name located at the root of /assets/js
 * and returns the hashed version of it
 *
 * this is used as a helper function in EJS templates, usable via `<%= js('app.js') %>`
 *
 * @param name basename, ie 'app.js'
 * @returns hashed name with full public path of the file, ie '/dist/assets/app.5e486f4a.js`
 */
const viteJsPath = (name: string) => {
  return viteAssetPath(`js/${name}`);
};

export const render = (absolutePath: string, params: any) => {
  return new Promise((resolve, reject) => {
    ejs.renderFile(
      absolutePath,
      { ...params, js: viteJsPath, css: viteCssPath },
      {},
      (err, str) => {
        if (err) {
          return reject(err);
        }

        return resolve(str);
      },
    );
  });
};

const getUserLabel = (req: Request) => {
  if (!isWithinLoggedInSession(req)) {
    //  do not display label when no session is found
    return null;
  }
  const user = getUserFromLoggedInSession(req);
  if (!user.given_name || !user.family_name) {
    //  display email when a name is missing
    return user.email;
  }
  return `${user.given_name} ${user.family_name}`;
};

// this is a cheap layout implementation for ejs
// it looks for the _layout file and inject the targeted template in the body variable
export const ejsLayoutMiddlewareFactory = (
  app: Application,
  use_dashboard_header: boolean = false,
) => {
  return function ejsLayoutMiddleware(
    req: Request,
    res: Response,
    next: NextFunction,
  ) {
    const orig = res.render;
    res.render = (view, locals = {}) => {
      app.render(
        view,
        { ...locals, js: viteJsPath, css: viteCssPath },
        (err: Error, html: string) => {
          if (err) throw err;
          orig.call(res, "_layout", {
            ...locals,
            // @ts-ignore
            js: viteJsPath,
            css: viteCssPath,
            body: html,
            header_user_label: getUserLabel(req),
            use_dashboard_header,
          });
        },
      );
    };
    next();
  };
};

export const renderWithEjsLayout = async (
  templateName: string,
  params = {},
) => {
  const bodyHtml = await render(
    path.resolve(`${import.meta.dirname}/../views/${templateName}.ejs`),
    params,
  );

  return await render(
    path.resolve(`${import.meta.dirname}/../views/_layout.ejs`),
    {
      ...params,
      body: bodyHtml,
    },
  );
};
