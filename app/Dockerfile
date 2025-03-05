FROM hugomods/hugo:base-0.145.0
RUN apk add --no-cache openssl

ENV DOCKERIZE_VERSION v0.7.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /app

ENTRYPOINT ["dockerize", "-wait", "http://metascraper:8080", "hugo"]
CMD ["server", "--bind=0.0.0.0"]
