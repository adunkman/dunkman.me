FROM mhart/alpine-node:15.5.1

WORKDIR /test

COPY ./package*.json ./
RUN npm ci

ENTRYPOINT ["npm", "test"]
