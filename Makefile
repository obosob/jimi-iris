SRC = $(shell find keyboards -type f)

COPIED = $(addprefix ../qmk_firmware/,$(SRC))

DIRS = $(sort $(foreach file,$(COPIED),$(dir $(file))))

.PHONY: flash

keebio_iris_rev3_jimi.hex: ../qmk_firmware/keebio_iris_rev3_jimi.hex
	cp $< $@

../qmk_firmware/keebio_iris_rev3_jimi.hex: $(COPIED)
	make -C ../qmk_firmware keebio/iris/rev3:jimi

flash: $(COPIED)
	make -C ../qmk_firmware keebio/iris/rev3:jimi:dfu

$(DIRS):
	mkdir -p $@

define make-goal
../qmk_firmware/$1: $1 | ../qmk_firmware/$2
	cp $$< $$@
endef

$(foreach file,$(SRC),$(eval $(call make-goal,$(file),$(dir $(file)))))
