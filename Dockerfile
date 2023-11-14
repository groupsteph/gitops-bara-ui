# BUILD STAGE
FROM node:18-slim as build-step

WORKDIR /app

COPY package.json /app/

RUN npm i

COPY . /app

RUN npm run build

# ========================================
# NGINX STAGE
# ========================================

FROM nginx:1.23

WORKDIR /usr/share/nginx/html/

COPY --from=build-step /app/dist ./

CMD [ "nginx", "-g", "daemon off;" ]