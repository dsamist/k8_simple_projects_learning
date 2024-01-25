FROM nginx

LABEL maintainer="samuel emmanuel <samist.se@gmail.com>"

COPY ./website /website

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
