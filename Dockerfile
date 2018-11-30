FROM openjdk:8-jdk-stretch

LABEL maintainer="me@dbak.ch"

ARG SUBSONIC_VERSION=6.1.4
ENV SUBSONIC_VERSION=${SUBSONIC_VERSION}
ARG SUBSONIC_ROOT=/subsonic
ENV SUBSONIC_ROOT=${SUBSONIC_ROOT}
ENV SUBSONIC_HOST=${SUBSONIC_HOST}
ARG SUBSONIC_PORT=4040
ENV SUBSONIC_PORT=${SUBSONIC_PORT}
ENV SUBSONIC_HTTPS_PORT=0
ENV SUBSONIC_CONTEXT_PATH=/
ENV SUBSONIC_DB=
ENV SUBSONIC_MAX_MEMORY=250
ENV SUBSONIC_PIDFILE=
ENV SUBSONIC_USER=subsonic
ENV SUBSONIC_HOME=/data/subsonic
ENV SUBSONIC_DEFAULT_MUSIC_FOLDER=/data/music
ENV SUBSONIC_DEFAULT_PODCAST_FOLDER=/data/podcasts
ENV SUBSONIC_DEFAULT_PLAYLIST_FOLDER=/data/playlists

LABEL version="$SUBSONIC_VERSION"
LABEL description="Subsonic Media Server"

RUN mkdir -p ${SUBSONIC_HOME} && \
    groupadd -g 1000 ${SUBSONIC_USER} && \
    useradd -u 1000 -d ${SUBSONIC_HOME} -g ${SUBSONIC_USER} -m ${SUBSONIC_USER} && \
    wget https://subsonic-public.s3.amazonaws.com/download/subsonic-${SUBSONIC_VERSION}-standalone.tar.gz && \
    mkdir -p ${SUBSONIC_ROOT} && \
    tar xf subsonic-${SUBSONIC_VERSION}-standalone.tar.gz -C ${SUBSONIC_ROOT} && \
    rm subsonic-${SUBSONIC_VERSION}-standalone.tar.gz

COPY subsonic.sh ${SUBSONIC_ROOT}/subsonic.sh

RUN chmod +x ${SUBSONIC_ROOT}/subsonic.sh

EXPOSE ${SUBSONIC_PORT}

CMD ${SUBSONIC_ROOT}/subsonic.sh
