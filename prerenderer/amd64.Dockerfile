FROM node:alpine

ARG BUILD_DATE
ARG VERSION
ARG REVISION

LABEL maintainer="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Sandro Jäckel <sandro.jaeckel@gmail.com>" \
  org.opencontainers.image.url="https://github.com/SuperSandro2000/docker-images/tree/master/prerender" \
  org.opencontainers.image.documentation="https://github.com/prerender/prerender" \
  org.opencontainers.image.source="https://github.com/SuperSandro2000/docker-images" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="SuperSandro2000" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.title="Prerenderer" \
  org.opencontainers.image.description="Node server that uses Headless Chrome to render a javascript-rendered page as HTML. To be used in conjunction with prerender middleware."

RUN export user=prerenderer \
  && addgroup -S $user && adduser -S $user -G $user

COPY [ "files/entrypoint.sh", "/usr/local/bin/" ]

RUN apk add --no-cache --no-progress chromium git \
  && git clone https://github.com/prerender/prerender.git /app \
  && apk del git

RUN npm install /app

COPY [ "files/server.js", "/app/" ]

EXPOSE 3000
WORKDIR /app
ENTRYPOINT [ "entrypoint.sh" ]
CMD ["npm", "start", "server"]
