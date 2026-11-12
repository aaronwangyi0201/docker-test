# Random Layer fixture

This Dockerfile generates one random-data image layer on the build worker.
The final image contains only `/data/random.bin` (104,833,024 bytes), matching
the existing approximately 100 MiB fixtures. Image size includes archive and
compression overhead; inspect the published manifest for its exact size.

Use `linux/amd64` and a different `MATERIAL_ID` build argument for each image.
The generation step consumes this argument so a new value invalidates its
build cache. Changing only the image tag does not generate fresh data.

ACR build settings:

- Dockerfile: `/Dockerfile`
- Context: repository root
- Build argument: `MATERIAL_ID=<batch>-<index>`
- Output tag: a unique tag matching that material ID

The build log prints the file SHA-256. Verify that each published image has
one layer and that the layer digests differ across the batch.
