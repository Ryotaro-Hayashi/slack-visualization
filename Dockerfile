FROM node:12.13.0-alpine

RUN mkdir project && \
    apk update && \
    npm install -g npm && \
    npm install -g @vue/cli && \
    npm install -g create-nuxt-app