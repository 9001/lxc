all:
	docker build -t static-tar .

	rm -rf rls
	
	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-tar:latest | \
	tar -xv
	
	chmod 755 rls/tar
