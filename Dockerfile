FROM node:14-alpine3.11 as builder
WORKDIR '/app'
COPY package.json .
RUN npm config set strict-ssl false
RUN npm install
COPY . .
RUN npm run build

# Second from means new block
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
#Default command starts nginx
