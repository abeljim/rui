# rui - desktop enviroment 
# See LICENSE for copyright and license details

VERSION = 0.0.1

BINFIX = /usr/bin
# temp fix 
SHAREFIX = /usr/share/rui-desktop
# SHAREFIX = ~/.config/awesome
XLOCATION = /usr/share/xsessions

install:
	# @echo installing executable file to ${BINFIX}
	# @mkdir -p ${BINFIX}
	# @cp -fr src/rui-desktop ${BINFIX}
	# @echo installing xsession file to ${XLOCATION}
	@mkdir -p ${XLOCATION}
	# @cp -f src/rui.desktop ${XLOCATION} temp comment out if no work
	@echo installing compton file to ${SHAREFIX}
	@mkdir -p ${SHAREFIX}
	@cp -f src/compton/compton.conf ${SHAREFIX}
	@echo installing awesome files to ${SHAREFIX}
	@mkdir -p ${SHAREFIX}
	@cp -fr src/awesome ${SHAREFIX}
	@echo installing rofi files
	@cp -fr src/rofi ${SHAREFIX}
	#@echo installing light/dark mode to ${BINFIX}
	#@cp -f src/bin/rui-darkmode ${BINFIX}
	#@cp -f src/bin/rui-lightmode ${BINFIX}
	@echo installing wallpapers to ${SHAREFIX}
	@cp -rf data/wallpapers ${SHAREFIX}
	# @echo installing font 
	# @cp data/typicons.ttf /usr/share/fonts/truetype/ 
	
	#gnome flashback
	@cp -f src/bin/rui-session ${BINFIX}
	@cp -f src/bin/rui-session-init ${BINFIX}
	
	@cp -f src/share/applications/rui.desktop /usr/share/applications
	@cp -f src/share/gnome-session/sessions/rui.session /usr/share/gnome-session/sessions
	@cp -f src/share/xsessions/rui.desktop /usr/share/xsessions

remove:
	@echo removing xsession file from ${XLOCATION}
	@rm -rf ${XLOCATION}/rui.desktop
	@echo removing share files at ${SHAREFIX}
	@rm -rf ${SHAREFIX}
