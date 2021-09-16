FROM node:alpine as builder

WORKDIR /app

COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .

RUN npm run build

# at this stage we have our prod app
# in /app/build within the container

FROM nginx 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
