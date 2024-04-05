FROM node:lts-slim AS base
RUN corepack enable
WORKDIR /app
COPY package*.json ./

FROM base AS prod-deps
ENV CYPRESS_INSTALL_BINARY=0
RUN --mount=type=cache,id=npm,target=/app/.npm \
  npm set cache /app/.npm && \
  npm ci --omit=dev

FROM base AS build
RUN --mount=type=cache,id=npm,target=/app/.npm \
  npm set cache /app/.npm && \
  npm ci
COPY tsconfig.json vite.config.mjs ./
COPY assets/ ./assets/
COPY src/ ./src/
RUN npx run-s build:*

FROM base
COPY --from=prod-deps /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist
COPY --from=build /app/build /app/build
EXPOSE 3000
CMD [ "npm", "start" ]
