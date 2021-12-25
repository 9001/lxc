builds a portable mpv sfx binary

the sfx also provides ffmpeg as a subcommand;
* `./mpv` launches mpv as usual
* `./mpv ffmpeg` runs ffmpeg instead
    * same goes for ffprobe and ffplay

features:
* hardware-accelerated encoding/decoding/filtering using amd/intel/nvidia cards
* redistributable GPL-licensed build
    * the GPL source and config-logs are bundled into the sfx for compliance
    * no problematic components such as fdk-aac (although can be enabled by uncommenting it)
        * please ignore the bundled aac encoder and consider using libopus instead
* enabled options:
    * video: x264, x265, vpx, vpx-vp9, aom, svt-av1, dav1d, theora
    * audio: opus, vorbis, lame-mp3, aac, gsm
    * accel: opengl, vaapi, nvenc, vdpau
    * subs: ass, freetype, fontconfig, fribidi
    * filters: rubberband, vmaf, opencl
    * input: cdio-paranoia
    * output: caca, drm, pulse, alsa
    * transport: gnutls


## building

either run `make` in this folder to build mpv for all supported platforms, or navigate into one of these subfolders and run `make` there:
* [centos7](./centos7/)
* [centos8](./centos8/)
* [debian-stable](./debian-stable/)


## notes

* the mpv team is planning to end support for centos7 soon
* intentional diffs:
  * centos8 has `libdvdnav` but not its `-devel`, so using `libdvdread` instead
