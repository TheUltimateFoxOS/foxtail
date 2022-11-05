function clean_dir {
	echo "Cleaning $1"
	(
		cd $1
		bash clean.sh
	)
}

if [ -d "pkgs" ]; then
	rm -rvf pkgs
fi

clean_dir intel_4004
clean_dir phoenix_tools
clean_dir intel_gpu
clean_dir figlet
clean_dir pride
clean_dir fun
