###############
### STAGE 1: Build app
###############
FROM node:18-alpine as build
ENV NODE_OPTIONS="--max-old-space-size=8192"
RUN npm install -g @angular/cli
WORKDIR /app
COPY . .
RUN npm install --save --legacy-peer-deps
RUN npm run build --prod

###############
### STAGE 2: Serve app with nginx ###
###############
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/. /usr/share/nginx/html
EXPOSE 80
