all:
	docker build -t static-pico2wave .
	
	rm -rf rls
	
	echo tar -cC /z rls | \
	docker run --rm --log-driver=none -i static-pico2wave:latest | \
	tar -xv
	
	mkdir rls/src
	cp -pv Dockerfile Makefile .dockerignore rls/src/
	chmod 755 rls/pico2wave
