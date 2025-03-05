FROM node:22-alpine3.21

WORKDIR /test

COPY ./package.json ./yarn.lock ./
RUN yarn

ENTRYPOINT ["yarn", "test"]
