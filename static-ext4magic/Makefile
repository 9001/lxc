all:
	-service docker start
	-systemctl start docker
	
	docker build -t static-ext4magic .
	
	rm -f ext4magic
	
	echo tar -cC/z rls | \
	docker run --rm -i static-ext4magic:latest | \
	tar -xv --strip-components=1
	
	-./ext4magic

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash

purge:
	@printf "\n\033[1;31mdeleting all docker containers\033[0m\n"
	docker rm `docker ps -qa` 2>/dev/null || true
	
	@printf "\n\033[1;31mdeleting all non-repo images\033[0m\n"
	docker rmi static-ext4magic 2>/dev/null || true
	docker rmi `docker images -qf "dangling=true"` 2>/dev/null || true
