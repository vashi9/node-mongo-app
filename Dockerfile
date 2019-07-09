FROM node:10

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . /app
EXPOSE 5005

CMD ["npm", "start"]
