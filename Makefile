.PHONY: install-dev start-local help
.DEFAULT_GOAL := help
run-venv = python -m venv
run-uvicorn = python -m uvicorn

install-dev: # Install dev dependencies
	rm -rf .venv && \
	$(run-venv) .venv && \
	source .venv/bin/activate && \
	pip install -r requirements/requirements_dev.txt

start-dev: # Start server in dev mode
	$(run-uvicorn) app.server:app --reload

help: # make help
	@awk 'BEGIN {FS = ":.*#"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?#/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)