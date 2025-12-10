
up: misp hive cortex wazuh

misp:
	docker compose -f docker-compose-misp.yml up -d

misp-down:
	docker compose -f docker-compose-misp.yml down

hive:
	docker compose -f docker-compose-hive.yml up -d

hive-down:
	docker compose -f docker-compose-hive.yml down

cortex:
	docker compose -f docker-compose-cortex.yml up -d

cortex-down:
	docker compose -f docker-compose-cortex.yml down

wazuh:
	./check_vm_map.sh
	cd wazuh-docker/single-node && docker compose up -d

wazuh-down:
	cd wazuh-docker/single-node && docker compose down

down: misp-down hive-down cortex-down wazuh-down
	

download:
	curl https://raw.githubusercontent.com/labs-practicals/SOC/refs/heads/main/MISP/docker-compose.yml --output docker-compose-misp.yml
	curl https://raw.githubusercontent.com/labs-practicals/SOC/refs/heads/main/THEHIVE/docker-compose.yml --output docker-compose-hive.yml
	curl https://raw.githubusercontent.com/labs-practicals/SOC/refs/heads/main/CORTEX/docker-compose.yml --output docker-compose-cortex.yml
	chmod +x check_vm_map.sh check_release_version.sh
	./check_release_version.sh

	