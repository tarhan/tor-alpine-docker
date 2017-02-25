FROM alpine:edge
MAINTAINER Dmitriy Lekomtsev <lekomtsev@gmail.com>

ENV EXIT_NODES ""
ENV COUNTRY ""
ENV PASSWORD "1234567890"

EXPOSE 9150 9051

COPY ./torrc /tmp/
COPY ./run.sh /run.sh

# Tor package now is in community repository so it does not needed to
# add additional repositories like @testing anymore.
RUN apk --no-cache add tor \
 && chmod a+w /tmp/torrc

USER tor

CMD ["/run.sh"]
