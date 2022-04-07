# MusicBot

[![Github Stars](https://img.shields.io/github/stars/callumpy/discord-musicbot-docker.svg?maxAge=43200&label=Github%20Stars)](https://github.com/callumpy/discord-musicbot-docker)
[![Docker Stars](https://img.shields.io/docker/stars/callumpy/discord-musicbot.svg?label=Docker%20Stars&maxAge=43200)](https://hub.docker.com/r/callumpy/discord-musicbot/)
[![Version](https://img.shields.io/docker/v/callumpy/discord-musicbot.svg?label=Version&sort=date&maxAge=43200)](https://hub.docker.com/r/callumpy/discord-musicbot/)
[![Docker Pulls](https://img.shields.io/docker/pulls/callumpy/discord-musicbot.svg?label=Docker%20Pulls&maxAge=43200)](https://hub.docker.com/r/callumpy/discord-musicbot/)

Fork of Jargosh MusicBot, but in a Docker Image for easier installation.

For configuration see the original authors Wiki: [github.com/jagrosh/MusicBot/wiki/Setup](https://github.com/jagrosh/MusicBot/wiki/Setup).

## Docker compose

````yaml
---
version: "3"
services:
  MusicBot:
    image: callumpy/MusicBot
    volumes:
      - $HOME/MusicBot:/data
````
