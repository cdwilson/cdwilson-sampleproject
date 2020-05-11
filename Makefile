.PHONY: all docs clean-docs view install dev-install pypi-install testpypi-install test build test-publish publish tidy clean

DIST_NAME := $(shell grep dist-name pyproject.toml | awk '{ print $$3 }')
PYPI_USERNAME := cdwilson
TESTPYPI_USERNAME := cdwilson
PYPI_INDEX_URL := https://pypi.org/simple/
TESTPYPI_INDEX_URL := https://test.pypi.org/simple/
TESTPYPI_UPLOAD_URL := https://test.pypi.org/legacy/

all: docs test build

docs:
	$(MAKE) -C docs html

clean-docs:
	-rm -rf docs/apidoc/
	-$(MAKE) -C docs clean

view:
	open docs/_build/html/index.html

install:
	flit install --deps=none

dev-install:
	flit install -s --deps=develop

pypi-install:
	pip install $(DIST_NAME)

testpypi-install:
	pip install --index-url $(TESTPYPI_INDEX_URL) --extra-index-url $(PYPI_INDEX_URL) $(DIST_NAME)

test:
	py.test tests

build:
	flit build

test-publish:
	FLIT_INDEX_URL="$(TESTPYPI_UPLOAD_URL)" FLIT_USERNAME="$(TESTPYPI_USERNAME)" flit publish

publish:
	FLIT_USERNAME="$(PYPI_USERNAME)" flit publish

tidy:
	find . -name \*.pyc -delete
	find . -name __pycache__ -delete

clean: clean-docs tidy
	-rm -rf *.egg-info dist
	-rm -f *.html
	-rm -rf .tox
	-rm -rf .pytest_cache
