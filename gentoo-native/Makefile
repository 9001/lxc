all:
	@printf "\033[35myou must choose a stage; src or bin\033[0m\n"

src:
	-service docker start
	-systemctl start docker
	
	-docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'

	export DOCKER_BUILDKIT=1 && \
	export DOCKER_CLI_EXPERIMENTAL=enabled && \
	docker buildx build --allow security.insecure -t gentoo-native-ffmpeg-src - < Dockerfile-src

bin:
	-service docker start
	-systemctl start docker
	
	-docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'

	export DOCKER_BUILDKIT=1 && \
	export DOCKER_CLI_EXPERIMENTAL=enabled && \
	docker buildx build --allow security.insecure -t gentoo-native-ffmpeg-bin - < Dockerfile-bin

# export DOCKER_BUILDKIT=1
# docker build --platform=local -o . https://github.com/docker/buildx
# mkdir -p ~/.docker/cli-plugins/
# mv buildx ~/.docker/cli-plugins/docker-buildx

# export DOCKER_CLI_EXPERIMENTAL=enabled
# export DOCKER_BUILDKIT=1
# make src
# make bin
