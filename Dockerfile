FROM node:14-alpine As development

WORKDIR /usr/src/app

COPY package.json ./
RUN yarn install
COPY . .
RUN yarn run build

FROM node:14-alpine as production

WORKDIR /usr/src/app

COPY package.json ./
RUN yarn install --production
COPY --from=development /usr/src/app/dist ./dist

EXPOSE 3000

CMD ["yarn", "start:prod"]
