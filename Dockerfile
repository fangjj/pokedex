FROM fangjimjim/alpine-node-nginx

COPY . /app/

WORKDIR /app

RUN npm install && \
    rm -rf build && \
    npm run build && \
    cp -r build/ /usr/html/ && \
    rm -rf /app

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log