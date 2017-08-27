FROM fangjimjim/alpine-node-nginx

COPY . /app/

WORKDIR /app

RUN npm i && \
    rm -rf build && \
    npm run build

# Add the files
COPY build/* /usr/html/

RUN rm -rf /app

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log