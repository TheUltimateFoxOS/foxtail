DIR=fonts

if [ -d "$DIR" ]; then
	echo "no need to download and convert again"
else
	echo "downloading and converting fonts..."
	(
		mkdir -p $DIR
		node figl.js
	)
fi


if [ -d "foxtail" ]; then
	rm -rvf foxtail
fi

make -f /opt/foxos_sdk/program.mak -C figlet PROGRAM_NAME=figlet.elf

mkdir -p foxtail
python3 ../foxtail.py figlet.json foxtail/install.c
make -f /opt/foxos_sdk/program.mak -C foxtail PROGRAM_NAME=figlet_install.elf
cp -v foxtail/bin/figlet_install.elf ../pkgs/figlet_install.elf