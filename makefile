#!/usr/bin/env make

# Build
ACTIVATE_VENV := true
AIRFLOW_HOME = $(pwd)

## Create Python virtual environment
venv:
	$(eval ACTIVATE_VENV := . .venv/bin/activate)
	[ -d .venv ] || ( python3 -m venv .venv \
		&& $(ACTIVATE_VENV) \
		&& pip3 install --upgrade pip )

requirements:
	( $(ACTIVATE_VENV) \
		&& python3 -m pip install --upgrade --upgrade-strategy eager \
		-r requirements.txt \
		-r requirements-test.txt )

local-standalone:
	( $(ACTIVATE_VENV) \
		&& airflow standalone)

local-init:
	docker compose up airflow-init

local-run:
	docker compose up -d

local-clean:
	docker compose down --volumes --remove-orphans
