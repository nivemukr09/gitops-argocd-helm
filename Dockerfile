# Sample Dockerfile - Nginx Hello App
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
