version := latest

.PHONY: build
build:
	docker build . -t booniepepper/nova-rust:$(version) >build.log

.PHONY: test
test: build
	docker run booniepepper/nova-rust:$(version) eval ":: dogs are blue :: spot is a dog"

.PHONY: release
release: build test
	docker push booniepepper/nova-rust:$(version)
