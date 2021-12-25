all: img pkg

img:
	-service docker start
	-systemctl start docker
	
	find Dockerfile.01
	sh -c 'cat Dockerfile.* | sed "s/=replacemebro/=-j`nproc`/"' > Dockerfile
	docker build -t mpv - <Dockerfile
	
	rm -rf rls
	mkdir rls
	echo "cp -pvR /rls/* /2host" | \
	docker run --rm -iv "${PWD}/rls:/2host" mpv:latest

pkg:
	cp -pvL Makefile Dockerfile ../common/checkver.sh sfx.sh rls/src/
	./sfx.sh create_sfx
	rm -rf rls

clean:
	rm -rf rls
	@printf '\n// see also "make purge" to clean docker containers/images\n'

purge:
	-service docker start
	-systemctl start docker
	
	@printf "\n\033[1;31mdeleting all docker containers\033[0m\n"
	docker rm `docker ps -qa` 2>/dev/null || true
	
	@printf "\n\033[1;31mdeleting all non-repo images\033[0m\n"
	docker rmi mpv 2>/dev/null || true
	docker rmi `docker images -qf "dangling=true"` 2>/dev/null || true

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/bash
