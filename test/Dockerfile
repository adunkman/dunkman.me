FROM node:20-alpine3.19

WORKDIR /test

COPY ./package.json ./yarn.lock ./
RUN yarn

ENTRYPOINT ["yarn", "test"]
