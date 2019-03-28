# rui - desktop enviroment 
# See LICENSE for copyright and license details

VERSION = 0.0.1

BINFIX = /usr/bin
SHAREFIX = /usr/share/rui-desktop
XLOCATION = /usr/share/xsessions

install:
	@echo installing executable file to ${BINFIX}
	@mkdir -p ${BINFIX}
	@cp -fr src/rui-desktop ${BINFIX}
	@echo installing xsession file to ${XLOCATION}
	@mkdir -p ${XLOCATION}
	@cp -f src/rui.desktop ${XLOCATION}
	

