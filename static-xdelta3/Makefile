all:
	service docker start
	
	docker build -t static-xdelta3 .
	
	echo "cat /xdelta3-static" | \
	docker run --rm -i static-xdelta3:latest > xdelta3-static
	
	chmod 755 xdelta3-static
