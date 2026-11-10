# -*- makefile-gmake -*-

all: scpt sdef


LIBS := ~/Library/Script\ Libraries
ROOT := $(LIBS)/BitwiseOps.scptd
INFO := $(ROOT)/Contents/Info.plist

# Install the script library to the user's ~/Library
install: scpt
	rm -rf "$(ROOT)"
	cp -vpR "`realpath ..`" "$(LIBS)/BitwiseOps.scptd"
	convert-plist -x "$(INFO)" > "$(INFO)~" && mv -f "$(INFO)~" "$(INFO)"
	open 'applescript://com.apple.scripteditor/?action=new'

# Compile the library as an execute-only file
scpt: Resources/Scripts/main.scpt
Resources/Scripts/main.scpt: Resources/Scripts/main.applescript
	osacompile -x -o $@ $^

# Generate legacy scripting definitions
sdef: Resources/BitwiseOperations.scriptSuite
Resources/BitwiseOperations.scriptSuite: Resources/ScriptingDictionary.sdef flush-cache
	sdp -f st -o Resources/ -V 10.10 $<
	cd Resources && for i in *.scriptSuite *.scriptTerminology; do \
		convert-plist "$$i" > "$$i~" && mv -f "$$i~" "$$i"; \
	done

# Delete generated files
clean: flush-cache
	rm -f Resources/*.scriptSuite
	rm -f Resources/*.scriptTerminology
	rm -f Resources/Scripts/main.scpt

# Delete cached scripting terminologies
flush-cache: quit-editor
	rm -f ~/'Library/Caches/Script Editor/SETerminology.cache'

# Quit ScriptEditor.app if it's running
quit-editor:
	@asn=`lsappinfo info -q -only asn com.apple.ScriptEditor2 | cut -d= -f2`; \
	if test -n "$$asn"; then \
		echo >&2 "Closing ScriptEditor.app…"; \
		lsappinfo quit -asn "$$asn"; \
	fi

.PHONY: clean flush-cache quit-editor
