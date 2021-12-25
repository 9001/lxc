all:
	service docker start
	
	docker build -t static-pixz .
	
	echo "cat /pixz-static" | \
	docker run --rm -i static-pixz:latest > pixz-static
	
	chmod 755 pixz-static

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash
