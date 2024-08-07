# Stage 1: Build stage
FROM alpine:3.20.1 as builder

RUN apk --no-cache add \
    ca-certificates \
    wget \
    jq \
    curl

# Allow version to be set via build arg, defaulting to 'latest'
ARG VERSION=latest

# Fetch release information and download the jar
RUN if [ "$VERSION" = "latest" ]; then \
        RELEASE=$(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | jq -r .tag_name); \
    else \
        RELEASE=$VERSION; \
    fi && \
    wget -q -O /JMusicBot.jar https://github.com/jagrosh/MusicBot/releases/download/${RELEASE}/JMusicBot-${RELEASE}.jar

# Stage 2: Production stage
FROM amazoncorretto:11.0.23-alpine3.19

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Callumpy" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Callumpy" \
  org.opencontainers.image.url="https://camo.githubusercontent.com/13a38b4fe8c6fdcac948830af73f55b1f675f408f37db6768e79de839b4d5320/68747470733a2f2f692e696d6775722e636f6d2f7a7245383048592e706e67" \
  org.opencontainers.image.documentation="https://github.com/jagrosh/MusicBot/wiki/" \
  org.opencontainers.image.source="https://github.com/Callumpy/discord-musicbot-docker" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="Discord MusicBot" \
  org.opencontainers.image.description="🎶 A Discord music bot that's easy to set up and run yourself!"

RUN adduser -D -h /home/MusicBot -s /sbin/nologin MusicBot

COPY --from=builder /JMusicBot.jar /JMusicBot.jar

RUN ln -sf /data/config.txt /config.txt && \
    ln -sf /data/Playlists /Playlists

USER MusicBot

WORKDIR /data
CMD [ "java", "-Dnogui=true", "-jar", "/JMusicBot.jar" ]