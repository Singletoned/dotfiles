bootstrap:
	sh scripts/bootstrap.sh

install: bootstrap
	sh scripts/setup_virtualenvs.sh
	python3 scripts/install.py
	sh scripts/setup_osx_defaults.sh
	sh scripts/symlinks.sh
	sh scripts/verify.sh
	@echo "🎉 Installation completed successfully!"

verify:
	sh scripts/verify.sh

.PHONY: bootstrap install verify
