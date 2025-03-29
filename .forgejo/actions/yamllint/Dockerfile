FROM alpine:3.21
RUN apk update && \
    apk add --no-cache yamllint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
