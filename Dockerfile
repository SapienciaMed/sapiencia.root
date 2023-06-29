FROM node:14-alpine AS root-sapiencia

WORKDIR /app
COPY . .
RUN npm install -g npm@8.0.0
RUN npm install
RUN npm run build
RUN npm prune --production

FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=root-sapiencia /app/dist /usr/share/nginx/html
EXPOSE 9000
