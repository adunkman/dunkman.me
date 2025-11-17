FROM node:25-alpine
RUN apk add --update python3 make linux-headers g++

WORKDIR /metascraper
COPY package.json yarn.lock ./
RUN yarn install

ENTRYPOINT ["yarn"]
CMD ["help"]
