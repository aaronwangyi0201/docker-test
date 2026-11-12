FROM busybox:1.37.0 AS generate
ARG MATERIAL_ID
RUN test -n "$MATERIAL_ID" \
    && mkdir -p /out/data \
    && dd if=/dev/urandom of=/out/data/random.bin bs=1024 count=102376 \
    && chmod 0644 /out/data/random.bin \
    && sha256sum /out/data/random.bin

FROM scratch
COPY --from=generate /out/ /
