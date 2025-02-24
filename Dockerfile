FROM node:18-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine

RUN npm install -g serve

WORKDIR /app

COPY --from=build /app/build .

EXPOSE 5000

CMD ["serve", "-s", ".", "-l", "5000"]