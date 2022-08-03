DIR=src

if [ -d "$DIR" ]; then
	echo "no need to clone again"
else
	echo "cloning..."
	git clone https://github.com/lpg2709/emulator-Intel-4004.git $DIR
fi


if [ -d "foxtail" ]; then
	rm -rvf foxtail
fi

make -f /opt/foxos_sdk/program.mak -C src PROGRAM_NAME=4004-emulator.elf

mkdir -p foxtail
python3 ../foxtail.py 4004_emulator.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=4004_install.elf
cp -v foxtail/bin/4004_install.elf ../pkgs/4004_install.elf