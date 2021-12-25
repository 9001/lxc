all:
	service docker start
	
	docker build -t static-pigz .
	
	echo "cat /pigz-static" | \
	docker run --rm -i static-pigz:latest > pigz-static
	
	chmod 755 pigz-static
