.PHONY: all docs clean-docs view install dev-install test build test-publish publish tidy clean

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

test:
	py.test tests

build:
	flit build

test-publish:
	FLIT_INDEX_URL="https://test.pypi.org/legacy/" FLIT_USERNAME="cdwilson" flit publish

publish:
	FLIT_INDEX_URL="https://pypi.org/legacy/" FLIT_USERNAME="cdwilson" flit publish

tidy:
	find . -name \*.pyc -delete
	find . -name __pycache__ -delete

clean: clean-docs tidy
	-rm -rf *.egg-info dist
	-rm -f *.html
	-rm -rf .tox
	-rm -rf .pytest_cache
