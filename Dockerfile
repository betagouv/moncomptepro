FROM node:lts-slim AS base
RUN corepack enable npm
WORKDIR /app

FROM base AS prod-deps
RUN --mount=type=bind,source=package.json,target=package.json \
  --mount=type=bind,source=package-lock.json,target=package-lock.json \
  --mount=type=cache,target=/root/.npm \
  npm ci --omit=dev

FROM base AS build
ENV CYPRESS_INSTALL_BINARY=0
RUN --mount=type=bind,source=package.json,target=package.json \
  --mount=type=bind,source=package-lock.json,target=package-lock.json \
  --mount=type=cache,target=/root/.npm \
  npm ci
COPY tsconfig.json vite.config.mjs ./
COPY assets/ ./assets/
COPY public/ ./public/
COPY src/ ./src/
COPY package*.json ./
RUN npx run-s build:*

FROM base
COPY package.json ./
COPY --from=prod-deps /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist
COPY --from=build /app/src /app/src

CMD [ "npm", "start" ]
