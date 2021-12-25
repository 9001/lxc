all:
	-service docker start
	-systemctl start docker
	
	docker build -t static-flite .
	
	rm -rf rls
	
	echo tar -cC /z rls | \
	docker run --rm -i static-flite:latest | \
	tar -xv
	
	mkdir rls/src
	cp -pv Dockerfile Makefile .dockerignore rls/src/
	chmod 755 rls/*
	(cd rls && ln -s ../res/cmu_us_slt.flitevox .)

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash

purge:
	@printf "\n\033[1;31mdeleting all docker containers\033[0m\n"
	docker rm `docker ps -qa` 2>/dev/null || true
	
	@printf "\n\033[1;31mdeleting all non-repo images\033[0m\n"
	docker rmi static-flite 2>/dev/null || true
	docker rmi `docker images -qf "dangling=true"` 2>/dev/null || true
