.PHONY: all install dev-install test build test-publish publish docs view clean-docs tidy clean

all: test docs dist

install:
	flit install --deps=none

dev-install:
	flit install -s --deps=develop

test:
	py.test tests

build:
	flit build

test-publish:
	FLIT_INDEX_URL="https://test.pypi.org/legacy/" FLIT_USERNAME="cdwilson" flit publish

publish:
	FLIT_INDEX_URL="https://pypi.org/legacy/" FLIT_USERNAME="cdwilson" flit publish

docs:
	$(MAKE) -C docs html

view:
	open docs/_build/html/index.html

clean-docs:
	-rm -rf docs/apidoc/
	-$(MAKE) -C docs clean

tidy:
	find . -name \*.pyc -delete
	find . -name __pycache__ -delete

clean: clean-docs tidy
	-rm -rf *.egg-info dist
	-rm -f *.html
	-rm -rf .tox
	-rm -rf .pytest_cache
