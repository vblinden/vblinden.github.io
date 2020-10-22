FROM jojomi/hugo:latest AS build
COPY . /src

FROM nginx:1.19.3-alpine
COPY --from=build /output /usr/share/nginx/html