FROM node:18-alpine3.16

WORKDIR /test

COPY ./package.json ./yarn.lock ./
RUN yarn

ENTRYPOINT ["yarn", "test"]
