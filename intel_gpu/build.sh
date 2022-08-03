DIR=src

if [ -d "$DIR" ]; then
	echo "no need to clone again"
else
	echo "cloning..."
	git clone https://github.com/Glowman554/intel_gpu.git $DIR
fi


if [ -d "foxtail" ]; then
	rm -rvf foxtail
fi

make -C src

mkdir -p foxtail
python3 ../foxtail.py intel_gpu.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=intel_gpu_install.elf
cp -v foxtail/bin/intel_gpu_install.elf ../pkgs/intel_gpu_install.elf