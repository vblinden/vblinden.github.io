FROM alpine:3.12 AS build

ENV HUGO_VERSION=0.76.5
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}

RUN wget -O - https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-ARM64.tar.gz | tar -xz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md

RUN apk add --update git asciidoctor libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates

WORKDIR /src
COPY . .
RUN hugo

FROM nginx:1.19.3-alpine
COPY --from=build /src/public /usr/share/nginx/html