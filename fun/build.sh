if [ -d "foxtail" ]; then
	rm -rvf foxtail
fi

function build_file {
	echo "Building $1..."
	make -f /opt/foxos_sdk/program.mak -C progs CSRC=$1.c PROGRAM_NAME=$1.elf

}

build_file lolcat
build_file matrix
build_file paint
build_file tic_tac_toe

make -C progs/nyanmbr

mkdir -p foxtail
python3 ../foxtail.py fun.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=fun_install.elf
cp -v foxtail/bin/fun_install.elf ../pkgs/fun_install.elf