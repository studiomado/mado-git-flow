prefix=/usr/local
datarootdir=$(prefix)/share

SCRIPT_FILES=gim-commit
SCRIPT_FILES+=gim-delete-local-branch
SCRIPT_FILES+=gim-delete-remote-branch
SCRIPT_FILES+=gim-genetate-new-branch-name
SCRIPT_FILES+=gim-get-actual-branch
SCRIPT_FILES+=gim-get-branch-name

init:
	chmod +x ./init.sh
	./init.sh
	install -d -m 0755 $(prefix)/bin
	install -m 0755 $(SCRIPT_FILES) $(prefix)/bin
