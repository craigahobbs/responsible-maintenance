# Licensed under the MIT License
# https://github.com/craigahobbs/responsible-maintenance/blob/main/LICENSE


# Download python-build
define WGET
ifeq '$$(wildcard $(notdir $(1)))' ''
$$(info Downloading $(notdir $(1)))
_WGET := $$(shell $(call WGET_CMD, $(1)))
endif
endef
WGET_CMD = if which wget; then wget -q -c $(1); else curl -f -Os $(1); fi
$(eval $(call WGET, https://craigahobbs.github.io/python-build/Makefile.base))
$(eval $(call WGET, https://craigahobbs.github.io/python-build/pylintrc))


# Set gh-pages source
GHPAGES_SRC := static/


# Include python-build
include Makefile.base


# Development dependencies
TESTS_REQUIRE := bare-script


# Disable pylint docstring warnings
PYLINT_ARGS := $(PYLINT_ARGS) --disable=missing-class-docstring --disable=missing-function-docstring --disable=missing-module-docstring


help:
	@echo "            [test-dashboard]"


clean:
	rm -rf Makefile.base pylintrc


.PHONY: test-dashboard
commit: test-dashboard
test-dashboard: $(DEFAULT_VENV_BUILD)
	$(DEFAULT_VENV_BIN)/bare -s static/*.mds static/test/*.mds
	$(DEFAULT_VENV_BIN)/bare -c 'include <markdownUp.bare>' static/test/runTests.mds$(if $(DEBUG), -d)$(if $(TEST), -v vTest "'$(TEST)'")
