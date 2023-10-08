all:
	docker build -t static-ntfs3g .

	rm -rf rls

	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-ntfs3g:latest | \
	tar -xv
	
	ls -al rls
	ldd rls/* | awk '!/^rls/ && !/statically linked$$/ {exit 1}; 1'
	rls/ntfs-3g -h 2>/dev/null || [ $$? -eq 9 ]

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash

purge:
	@printf "\n\033[1;31mdeleting all docker containers\033[0m\n"
	docker rm `docker ps -qa` 2>/dev/null || true
	
	@printf "\n\033[1;31mdeleting all non-repo images\033[0m\n"
	docker rmi static-ntfs3g 2>/dev/null || true
	docker rmi `docker images -qf "dangling=true"` 2>/dev/null || true
