all:
	docker build -t static-7z .
	
	rm -rf rls
	
	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-7z:latest | \
	tar -xv
	
	ls -al rls/7z
	ldd rls/* | awk '1; !/^rls\// && !/statically linked$$/ {exit 1}'
	rls/7z -h >/dev/null
	
	cp -pv run.sh sfx.sh rls
	(cd rls && ./sfx.sh create_sfx 7z)
	rm -rf rls
	mkdir rls
	mv 7z.sfx rls/7z

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash

purge:
	@printf "\n\033[1;31mdeleting all docker containers\033[0m\n"
	docker rm `docker ps -qa` 2>/dev/null || true
	
	@printf "\n\033[1;31mdeleting all non-repo images\033[0m\n"
	docker rmi static-7z 2>/dev/null || true
	docker rmi `docker images -qf "dangling=true"` 2>/dev/null || true
