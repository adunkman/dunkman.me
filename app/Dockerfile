FROM alpine:3.12
RUN apk add --no-cache hugo=0.71.1-r0

WORKDIR /app

ENTRYPOINT ["hugo"]
CMD ["server", "--bind=0.0.0.0"]
