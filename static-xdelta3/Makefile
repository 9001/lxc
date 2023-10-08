all:
	docker build -t static-xdelta3 .
	
	rm -rf rls

	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-xdelta3:latest | \
	tar -xv
	
	chmod 755 rls/xdelta3
