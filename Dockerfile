FROM mhart/alpine-node:8

COPY . /app/

WORKDIR /app

RUN npm install && \
    rm -rf build && \
    npm run build && \
    cp -r build/ /usr/html/ && \
    rm -rf /app

