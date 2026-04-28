.PHONY: generate-config validate-config debug-bws help

# Generate AiuriSDKConfig implementation from BWS (Bitwarden Secrets Manager)
generate-config:
	@echo "Generating AiuriSDKConfig implementation from BWS..."
	@bws secret list | python3 generate_keys.py

# Debug BWS connection and credentials
debug-bws:
	@echo " Debugging BWS connection..."
	@python3 debug_bws.py

# Validate that config file exists
validate-config:
	@if [ ! -f lib/config/aiuri_config_generated.dart ]; then \
		echo " Configuration file not found!"; \
		echo "   Run: make generate-config"; \
		echo "   Or debug: make debug-bws"; \
		exit 1; \
	fi
	@echo " Configuration file exists"

# Show help
help:
	@echo "Available commands:"
	@echo ""
	@echo "  make generate-config    - Generate config from BWS"
	@echo "  make debug-bws          - Debug BWS connection"
	@echo "  make validate-config    - Check if config exists"
	@echo "  make help               - Show this help"
	@echo ""
	@echo "Quick start:"
	@echo "  1. make debug-bws (to verify BWS is working)"
	@echo "  2. make generate-config"
	@echo "  3. Copy lib/main.dart.example to lib/main.dart"
	@echo "  4. flutter run"
