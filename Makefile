version := latest

.PHONY: build
build:
	docker build . -t booniepepper/nova-rust:$(version) >build.log

.PHONY: test
test: build
	docker run booniepepper/nova-rust:$(version) eval "|foo| bar || foo"

.PHONY: test-discord
test-discord: build
	docker run booniepepper/nova-rust:$(version) eval-discord "|bar| baz || bar"

.PHONY: release
release: build test
	docker push booniepepper/nova-rust:$(version)
