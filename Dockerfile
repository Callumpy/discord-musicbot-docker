FROM debian:testing-slim as git

RUN apt-get update -q \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    wget \
  && rm -rf /var/lib/apt/lists/*

ARG VERSION=0.3.8
RUN wget -q -O JMusicBot.jar -- https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION.jar

#--------------#

FROM openjdk:11-jre-slim

ARG VERSION

LABEL maintainer="Callumpy" \
  org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="Callumpy" \
  org.opencontainers.image.url="https://camo.githubusercontent.com/13a38b4fe8c6fdcac948830af73f55b1f675f408f37db6768e79de839b4d5320/68747470733a2f2f692e696d6775722e636f6d2f7a7245383048592e706e67" \
  org.opencontainers.image.documentation="https://github.com/jagrosh/MusicBot/wiki/" \
  org.opencontainers.image.source="https://github.com/Callumpy/discord-musicbot-docker" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="Callumpy" \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="Discord MusicBot" \
  org.opencontainers.image.description="🎶 A Discord music bot that's easy to set up and run yourself!"

RUN export user=MusicBot \
  && groupadd -r $user && useradd -r -g $user $user

COPY --from=git [ "/JMusicBot.jar", "/JMusicBot.jar" ]

RUN ln -rs /data/config.txt /config.txt \
  && ln -rs /data/Playlists /Playlists

WORKDIR /data
CMD [ "java", "-Dnogui=true", "-jar", "/JMusicBot.jar" ]