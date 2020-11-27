FROM garland/aws-cli-docker

WORKDIR /app
RUN apk add --update nodejs npm

COPY sqs_receiver/* /app/

RUN npm install

CMD node server.js