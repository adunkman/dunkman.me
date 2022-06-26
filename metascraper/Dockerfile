FROM node:18-alpine3.16
RUN apk add --update python3 make g++

WORKDIR /metascraper
COPY package.json yarn.lock ./
RUN yarn install

ENTRYPOINT ["yarn"]
CMD ["help"]
