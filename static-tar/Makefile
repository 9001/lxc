all:
	service docker start
	
	docker build -t static-tar .
	
	echo "cat /tar-static" | \
	docker run --rm -i static-tar:latest > tar-static
	
	chmod 755 tar-static
