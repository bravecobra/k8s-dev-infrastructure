# build the docker image, tag it and push it to the k8s registry
docker build -f ".\TelemetrySampleWeb\Dockerfile" --force-rm -t telemetrysampleweb .
docker tag telemetrysampleweb:latest localhost:5000/telemetrysampleweb:latest
docker push localhost:5000/telemetrysampleweb:latest
