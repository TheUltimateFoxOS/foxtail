if [ -d "foxtail" ]; then
	rm -rvf foxtail
fi

make -f /opt/foxos_sdk/program.mak -C pride PROGRAM_NAME=pride.elf

mkdir -p foxtail
python3 ../foxtail.py pride.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=pride_install.elf
cp -v foxtail/bin/pride_install.elf ../pkgs/pride_install.elf