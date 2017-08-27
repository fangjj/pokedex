FROM smebberson/alpine-nginx
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

ENV NODE_VERSION=v6.4.0 NPM_VERSION=3

RUN apk add --update curl make gcc g++ python linux-headers libgcc libstdc++ binutils-gold && \
    curl -sSL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.gz | tar -xz && \
    cd /node-${NODE_VERSION} && \
    ./configure --prefix=/usr --fully-static --without-npm && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    cd / && \
    npm install -g npm@${NPM_VERSION} && \
    apk del gcc g++ python linux-headers binutils-gold libstdc++ libgcc && \
    rm -rf /var/cache/apk/* /etc/ssl /node-${NODE_VERSION}* /usr/include \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts

COPY . /app/

WORKDIR /app

RUN npm i && \
    rm -rf build && \
    npm run build

# Add the files
ADD build/ /usr/html/

RUN rm -rf /app

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log