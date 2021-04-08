FROM node:alpine
RUN mkdir /home/node/app && chown -R node:node /home/node
WORKDIR /home/node/app
USER node
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /home/node/app/build /usr/share/nginx/html