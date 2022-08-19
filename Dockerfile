FROM node:18-alpine3.15 as builder
WORKDIR '/app'
COPY package.json .
COPY package-lock.json .
RUN npm config set strict-ssl false
RUN npm install --silent
COPY . .
RUN npm run build

# Second from means new block
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
#Default command starts nginx
