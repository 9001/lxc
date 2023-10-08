all:
	docker build -t static-pigz .
	
	rm -rf rls
	
	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-pigz:latest | \
	tar -xv
	
	chmod 755 rls/pigz

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash
