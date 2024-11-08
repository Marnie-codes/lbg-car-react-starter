# stage 1
FROM node:19-alpine as build

# change into a folder called /app
WORKDIR /app

# only copy package.json
COPY Frontend/package.json .

# download the project dependencies
RUN npm install --force

# copy everything from the react app folder to the /app folder in the container
COPY Frontend .

ARG SERVER_URL=localhost

RUN chmod +x set_env.sh
RUN sh set_env.sh

# package up the react project in the /app directory
RUN npm run build

# stage 2
FROM nginx:1.23-alpine
COPY --from=build /app/build /usr/share/nginx/html

COPY Frontend/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
