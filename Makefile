BIN = ./node_modules/.bin

install link:
	@npm $@

test:
	@$(BIN)/mocha -t 5000 -b -R spec spec.js

lint:
	jsxhint -c .jshintrc ./index.js

release-patch: lint test
	@$(call release,patch)

release-minor: lint test
	@$(call release,minor)

release-major: lint test
	@$(call release,major)

publish:
	uglify index.js > dist/react-breadcrumbs.min.js
	git commit -am "new release"
	git push --tags origin HEAD:master
	npm publish

define release
	npm version $(1)
endef
