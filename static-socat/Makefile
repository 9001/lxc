all:
	docker build -t static-socat .

	rm -rf rls
	
	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-socat:latest | \
	tar -xv
	
	chmod 755 rls/socat
