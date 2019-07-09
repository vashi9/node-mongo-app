FROM node:10

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . /app
EXPOSE 5005
EXPOSE 5006

CMD ["npm", "start"]
