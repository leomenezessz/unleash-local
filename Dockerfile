FROM unleashorg/unleash-server:3.17.6

USER root

WORKDIR /unleash

ENV PATH=$PATH:/home/node/.npm-global/bin

RUN apk update && apk upgrade && apk add curl bash

ENV UNLEASH_APP_NAME="default"
ENV UNLEASH_ENABLE_API_TOKEN="false"
ENV UNLEASH_AUTH_TYPE="none"
ENV DB_HOST "0.0.0.0"
ENV DB_USER "postgrees"
ENV DB_PORT 5432
ENV DB_PASSWORD "passord"
ENV DB_NAME "unleash"
ENV DATABASE_SSL "false"
ENV ACTION "create"
ENV TOGGLES "test"

COPY unleash.sh .
COPY server.js .

RUN ["chmod", "+x", "unleash.sh"]

ENTRYPOINT ["node", "server.js"]

