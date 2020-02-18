release:
	docker build --tag elixir_distillery .
	docker run -it -v ${PWD}:/api elixir_distillery bash -c \
		"cd /api && \
		mix deps.get && \
		MIX_ENV=prod mix compile && \
		MIX_ENV=prod mix distillery.release --verbose --env prod"

release_upgrade:
	# Check for version bump
	docker build --tag elixir_distillery .
	docker run -it -v ${PWD}:/api elixir_distillery bash -c \
		"cd /api && \
		mix deps.get && \
		MIX_ENV=prod mix compile && \
		MIX_ENV=prod mix distillery.release --verbose --env prod --upgrade"
