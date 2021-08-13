FROM mhart/alpine-node:15.5.1

WORKDIR /test

COPY ./package.json ./yarn.lock ./
RUN yarn

ENTRYPOINT ["yarn", "test"]
