FROM node:20-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN npm i

COPY . .

RUN npm run build --prod --base-href=/browser/

FROM nginx:alpine

COPY --from=builder /app/dist/* /usr/share/nginx/html

COPY ngnix.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]