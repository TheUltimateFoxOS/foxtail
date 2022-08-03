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
	bash build_foxos.sh
)

mkdir -p foxtail
python3 ../foxtail.py ccpu_tools.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=ccpu_tools_install.elf
cp -v foxtail/bin/ccpu_tools_install.elf ../pkgs/ccpu_tools_install.elf