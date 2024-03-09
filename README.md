# MusicBot

![GitHub Repo stars](https://img.shields.io/github/stars/callumpy/discord-musicbot-docker)
![Docker Stars](https://img.shields.io/docker/stars/callumpy/discord-musicbot)
[![Docker Image Version](https://img.shields.io/docker/v/callumpy/discord-musicbot?sort=date)](https://img.shields.io/docker/v/callumpy/discord-musicbot/0.4.0
![Docker Pulls](https://img.shields.io/docker/pulls/callumpy/discord-musicbot)

This repo is a Fork of Jargosh MusicBot, but in a Docker Image for easier installation.

Container is running with Alpine and Amazon Corretto Java to try and keep the footprint really small but also improving security over the OpenJDK that's recommended. 

## Setup:

You need a `config.txt` file to run the musicbot, otherwise it will terminate and the container stops. 
Please refer to the the original author's Wiki for details on creating the configuration and setting up API token in the Discord developer portal: [github.com/jagrosh/MusicBot/wiki/Setup](https://github.com/jagrosh/MusicBot/wiki/Setup).

## Docker compose:

````yaml
---
version: "3"
services:
  MusicBot:
    image: callumpy/discord-musicbot:latest
    volumes:
      - $HOME/MusicBot:/data
````
