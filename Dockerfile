FROM jsavargas/zspotify:develop as base

RUN apk --update add git ffmpeg

FROM base as builder

WORKDIR /install

COPY requirements.txt /requirements.txt
RUN apk add gcc libc-dev zlib zlib-dev jpeg-dev \
    && pip install --prefix="/install" -r /requirements.txt


FROM base

WORKDIR /app
COPY --from=builder /install /usr/local

COPY zspotify.py /app

VOLUME /download /config

ENTRYPOINT ["/usr/local/bin/python3", "zspotify.py"]

