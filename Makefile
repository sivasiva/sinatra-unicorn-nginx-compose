.PHONY: setup serve clean shell

setup:
	clear
	docker-compose build

serve: setup
	docker-compose up

clean:
	docker-compose down --rmi local -v

shell:
	docker-compose run app bash

test:
	bash url_tests.sh

u:
	clear
	cd app && bundle exec unicorn -p 9292 -c unicorn.rb