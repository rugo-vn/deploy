FROM ubuntu:20.04

# global
RUN apt-get update &&\
  apt-get install -y --no-install-recommends curl git nano sudo ca-certificates procps libfontconfig --no-install-recommends \
  debian-keyring debian-archive-keyring apt-transport-https zip unzip wget

# nodejs
RUN SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.5/supercronic-linux-amd64 \
  && SUPERCRONIC=supercronic-linux-amd64 \
  && SUPERCRONIC_SHA1SUM=9aeb41e00cc7b71d30d33c57a2333f2c2581a201 \
  && curl -fsSLO "$SUPERCRONIC_URL" \
  && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
  && chmod +x "$SUPERCRONIC" \
  && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
  && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

RUN useradd -ms /bin/bash docker && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get update &&\
  apt-get install -y --no-install-recommends gnupg &&\
  curl -sL https://deb.nodesource.com/setup_16.x | bash - &&\
  apt-get update &&\
  apt-get install -y --no-install-recommends nodejs

RUN node --version
RUN npm --version

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]