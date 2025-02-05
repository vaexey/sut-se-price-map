COMPOSE := compose
COMPOSE_DEV := compose.dev
COMPOSE_CI := compose.ci

up:
	docker compose -f $(COMPOSE).yaml up

up-build:
	docker compose -f $(COMPOSE).yaml up --build	

down:
	docker compose -f $(COMPOSE).yaml down

clean:
	docker compose -f $(COMPOSE).yaml down -v

up-%: compose.%.yaml
	docker compose -f $< up

up-build-%: compose.%.yaml
	docker compose -f $< up --build	

down-%: compose.%.yaml
	docker compose -f $< down

clean-%: compose.%.yaml
	docker compose -f $< down -v
