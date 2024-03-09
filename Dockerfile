# Stage 1: Build stage
FROM alpine:3.19 as builder

RUN apk --no-cache add \
    ca-certificates \
    wget

ARG VERSION=0.4.0
RUN wget -q -O /JMusicBot.jar https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION.jar

# Stage 2: Production stage
FROM amazoncorretto:11.0.22-alpine3.19

ARG VERSION

LABEL maintainer="Callumpy" \
  org.opencontainers.image.source="https://github.com/Callumpy/discord-musicbot-docker" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.title="Discord MusicBot" \
  org.opencontainers.image.description="🎶 A Discord music bot that's easy to set up and run yourself!"

RUN adduser -D -h /home/MusicBot -s /sbin/nologin MusicBot

COPY --from=builder /JMusicBot.jar /JMusicBot.jar

RUN ln -sf /data/config.txt /config.txt && \
    ln -sf /data/Playlists /Playlists

USER MusicBot

WORKDIR /data
CMD [ "java", "-Dnogui=true", "-jar", "/JMusicBot.jar" ]
