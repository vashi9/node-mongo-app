FROM node:10

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . /app
EXPOSE 5005

CMD ["npm", "start"]
