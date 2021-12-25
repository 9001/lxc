all: c7 c8 debs

c7:
	cd centos7 && $(MAKE)
	mv centos7/mpv mpv-centos7

c8:
	cd centos8 && $(MAKE)
	mv centos8/mpv mpv-centos8

debs:
	cd debian-stable && $(MAKE)
	mv debian-stable/mpv mpv-debian-stable
