all:
	-service docker start
	-systemctl start docker
	
	docker build -t static-pv .
	
	rm -f pv-static
	
	echo tar -cC/ pv-static | \
	docker run --rm -i static-pv:latest | \
	tar -xv
	
	ls -al ./pv-static
	-ldd ./pv-static
	./pv-static -h

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash

purge:
	@printf "\n\033[1;31mdeleting all docker containers\033[0m\n"
	docker rm `docker ps -qa` 2>/dev/null || true
	
	@printf "\n\033[1;31mdeleting all non-repo images\033[0m\n"
	docker rmi static-pv 2>/dev/null || true
	docker rmi `docker images -qf "dangling=true"` 2>/dev/null || true
