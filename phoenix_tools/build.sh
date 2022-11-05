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
	cd $DIR/tools
    bash build_foxos.sh
)

mkdir -p foxtail
python3 ../foxtail.py phoenix_tools.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=phoenix_tools_install.elf
cp -v foxtail/bin/phoenix_tools_install.elf ../pkgs/phoenix_tools_install.elf
