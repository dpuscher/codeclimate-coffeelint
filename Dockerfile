FROM alpine:edge

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk --update add nodejs ruby ruby-dev ruby-bundler build-base && \
    npm install -g coffeelint && \
    bundle install -j 4 && \
    apk del build-base && rm -fr /usr/share/ri

RUN adduser -u 9000 -D app
USER app

COPY . /usr/src/app

CMD ["/usr/src/app/bin/coffeelint"]
