FROM node:16-alpine3.11

WORKDIR /metascraper
COPY package.json yarn.lock ./
RUN yarn install

ENTRYPOINT ["yarn"]
CMD ["help"]
