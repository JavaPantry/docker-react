# specify tagged base imnage
FROM node:alpine as builder

# add working directory in docker FS'
WORKDIR '/app'

# Download and install dependencies
# no need because of `FROM node:alpine`: RUN apk add --update node

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# Run phase

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx container will start Nginx-server for us by default, so there no need to specify CMD
# CMD ["nginx"]
