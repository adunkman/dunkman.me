FROM node:25-alpine

WORKDIR /test

COPY ./package.json ./yarn.lock ./
RUN yarn

ENTRYPOINT ["yarn", "test"]
