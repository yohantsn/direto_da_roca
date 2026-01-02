export OUTPUT_FILE=core_sdk/repository/secrets/app_keys.dart

.PHONY: generate-keys

generate-keys:
	@bws secret list | python3 generate_keys.py
