DIR=src

if [ -d "$DIR" ]; then
	echo "no need to clone again"
else
	echo "cloning..."
	git clone https://github.com/Nudeltruppe/CpuV2 $DIR
fi


if [ -d "foxtail" ]; then
	rm -rvf foxtail
fi

(
	cd $DIR 

	function build_dir {
		(
			cd $1
			make -f /opt/foxos_sdk/program.mak PROGRAM_NAME=$2 USER_CFLAGS="-Wno-write-strings -Wno-format-overflow" USER_CPPFLAGS="-Wno-write-strings -Wno-format-overflow"
		)
	}

	function build_file {
		(
			cd $1
			make -f /opt/foxos_sdk/program.mak PROGRAM_NAME=$2 USER_CFLAGS="-Wno-write-strings -Wno-format-overflow" CSRC=$3 USER_CPPFLAGS="-Wno-write-strings -Wno-format-overflow"
		)
	}

	build_dir assembler ccpu-as.elf

	build_file tools ccpu-disas.elf disassembler.c
	build_file tools ccpu-emu.elf emulator.c
)

mkdir -p foxtail
python3 ../foxtail.py ccpu_tools.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=ccpu_tools_install.elf
cp -v foxtail/bin/ccpu_tools_install.elf ../pkgs/ccpu_tools_install.elf