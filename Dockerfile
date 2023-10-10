FROM node:18-alpine as builder

WORKDIR /usr/src/app

COPY . .

RUN npm run build

FROM node:18-alpine as production

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./package.json

CMD [ "npm", "run", "start:prod" ]