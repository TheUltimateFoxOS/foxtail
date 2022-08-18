bash build_packets.sh

(
	cd pkgs
	ls > ../all.fsh
	mv ../all.fsh .
)

make -f /opt/foxos_sdk/disk.mak FOLDER=pkgs image run