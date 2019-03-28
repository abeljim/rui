# rui - desktop enviroment 
# See LICENSE for copyright and license details

VERSION = 0.0.1

BINFIX = /usr/bin
SHAREFIX = /usr/share/rui-desktop
XLOCATION = /usr/share/xsessions

install:
	# @echo installing executable file to ${BINFIX}
	# @mkdir -p ${BINFIX}
	# @cp -fr src/rui-desktop ${BINFIX}
	@echo installing xsession file to ${XLOCATION}
	@mkdir -p ${XLOCATION}
	@cp -f src/rui.desktop ${XLOCATION}
	@echo installing compton file to ${SHAREFIX}
	@mkdir -p ${SHAREFIX}
	@cp -f src/compton/compton.conf ${SHAREFIX}
	@echo installing awesome files to ${SHAREFIX}
	@mkdir -p ${SHAREFIX}
	@cp -fr src/awesome ${SHAREFIX}

remove:
	@echo removing xsession file from ${XLOCATION}
	@rm -rf ${XLOCATION}/rui.desktop
	@echo removing share files at ${SHAREFIX}
	@rm -rf ${SHAREFIX}
