all:
	docker build -t static-rsync .
	
	rm -rf rls

	echo tar -cC/ rls | \
	docker run --rm --log-driver=none -i static-rsync:latest | \
	tar -xv
	
	chmod 755 rls/rsync
