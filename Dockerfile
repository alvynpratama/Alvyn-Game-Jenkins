FROM node:18-alpine AS builder
WORKDIR /app

RUN npm install -g expo-cli

COPY package*.json ./

RUN npm install

COPY . .

RUN npx expo export

FROM node:18-alpine

WORKDIR /app

RUN npm install -g serve

EXPOSE 8081

COPY --from=builder /app/dist ./dist

CMD ["serve", "-s", "dist", "-l", "8081"]

