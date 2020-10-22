FROM jojomi/hugo:latest AS build
COPY . /src
RUN hugo

FROM nginx:1.19.3-alpine
COPY --from=build /src/public /usr/share/nginx/html