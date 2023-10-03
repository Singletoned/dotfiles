install:
	sh scripts/setup_virtualenvs.sh
	python3 scripts/install.py
	sh scripts/setup_osx_defaults.sh
	sh scripts/symlinks.sh
