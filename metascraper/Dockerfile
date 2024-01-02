FROM node:20-alpine3.19
RUN apk add --update python3 make g++

WORKDIR /metascraper
COPY package.json yarn.lock ./
RUN yarn install

ENTRYPOINT ["yarn"]
CMD ["help"]
