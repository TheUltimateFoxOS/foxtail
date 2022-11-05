function build_dir {
	echo "Building $1"
	(
		cd $1
		bash build.sh
	)
}

if [ -d "pkgs" ]; then
	rm -rvf pkgs
fi

mkdir -p pkgs

build_dir intel_4004
build_dir phoenix_tools
build_dir intel_gpu
build_dir figlet
build_dir pride
build_dir fun
