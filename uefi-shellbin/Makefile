all:
	docker build -t uefi-shellbin .

	rm -rf rls

	echo "tar -c /rls" | \
	docker run --rm -i uefi-shellbin:latest | tar -xv

sh:
	@printf "\n\033[36mopening a shell in the most recently created docker image\033[0m\n"
	docker run --rm -it `docker image ls -aq | head -n 1` /bin/ash
