all:
	-service docker start
	-systemctl start docker
	
	docker build -t static-rsync .
	
	echo "cat /rsync-static" | \
	docker run --rm -i static-rsync:latest > rsync-static
	
	chmod 755 rsync-static
