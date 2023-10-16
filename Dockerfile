FROM node:current-bullseye-slim AS prod

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# RUN npm test - if you want to test before to build
RUN npm run build

FROM nginx:1.25.1-alpine3.17-slim
WORKDIR /usr/share/nginx/html
COPY --from=prod /app/build .
EXPOSE 80
# run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
