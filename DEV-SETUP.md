# Environment Setup and Secrets Management

This project uses **Bitwarden Secrets Manager** to manage API keys and sensitive credentials (such as Supabase keys) securely. This approach eliminates the need for shared `.env` files and ensures that secrets are never committed to the version control system.

## Prerequisites

Before starting, ensure you have the following tools installed:

1. [Bitwarden Secrets Manager CLI (bws)](https://bitwarden.com/help/secrets-manager-cli/)
2. [Python 3.x](https://www.python.org/) (for code generation)

## Configuration Steps

### 1. Backend Setup (Supabase)
Each developer must use their own Supabase instance for development:
1. Create an account at [supabase.com](https://supabase.com).
2. Create a new project.
3. Locate your `SUPABASE_URL` and `SUPABASE_ANON_KEY` under **Project Settings > API**.

### 2. Secrets Management (Bitwarden)
1. Sign in to the [Bitwarden Web Vault](https://vault.bitwarden.com).
2. Navigate to the **Secrets Manager** section and create a new **Project** (e.g., `MyProject-Dev`).
3. Add the following secrets to the project:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`
4. Go to **Machine Accounts**, create a new account, and generate an **Access Token**.
5. **Crucial:** Assign the Machine Account to your Project with **Read** permissions.

### 3. Local Environment Variables
In your bash or zshrc file add the token from your Bitwarden account:

```bash
BWS_ACCESS_TOKEN="your_access_token_here"

# Uncomment the following lines if your account is hosted in the EU region:
# BWS_IDENTITY_URL="[https://identity.bitwarden.eu](https://identity.bitwarden.eu)"
# BWS_API_URL="[https://api.bitwarden.eu](https://api.bitwarden.eu)"
```

## Generating the Configuration for AiuriSDK

The project uses a script to fetch secrets from Bitwarden and generate a Dart configuration class that implements `AiuriSDKConfig` (the SDK's interface).

### Quick Start (2 Steps)

#### Step 1: Generate Configuration from BWS

```bash
make generate-config
```

This creates: `lib/config/aiuri_config_generated.dart`

This file implements `AiuriSDKConfig` with your actual Supabase credentials and includes a pre-configured instance ready to use.

#### Step 2: Initialize in main.dart

```dart
import 'package:aiuri_sdk/aiuri_sdk.dart';
import 'config/aiuri_config_generated.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SDK with pre-configured credentials
  await AiuriSDK.initialize(aiuriConfig);
  
  runApp(const MyApp());
}
```

Or copy the example:
```bash
cp lib/main.dart.example lib/main.dart
```

Then run:
```bash
flutter run
```

### Generated File Structure

The script generates a Dart class like this:

```dart
// GENERATED FILE - DO NOT MODIFY MANUALLY
import 'package:aiuri_sdk/aiuri_sdk.dart';

class GeneratedAiuriConfig implements AiuriSDKConfig {
  @override
  final String supabaseUrl;
  
  @override
  final String supabaseAnonKey;
  
  GeneratedAiuriConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });
}

// Pre-configured instance ready to use
final aiuriConfig = GeneratedAiuriConfig(
  supabaseUrl: 'https://your-project.supabase.co',
  supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
);
```

### Security

[!CAUTION] Security Warning: The `aiuri_config_generated.dart` file contains plain-text credentials and must never be committed to the repository. It is included in the `.gitignore` by default.

## Development Workflow

### When You Update Secrets in Bitwarden

1. **Update** a secret value in the Bitwarden Web UI.

2. **Regenerate** the configuration:
   ```bash
   make generate-config
   ```

3. **Rebuild** the app:
   ```bash
   flutter run
   ```

The new credentials will be picked up by AiuriSDK on the next app start.

### AiuriSDK Configuration Flow

```
Bitwarden Web UI
    ↓
bws secret list (CLI command)
    ↓
generate_keys.py (Python script)
    ↓
lib/config/aiuri_config_generated.dart (Generated Dart class)
    ↓
aiuriConfig (Pre-configured instance)
    ↓
AiuriSDK.initialize(aiuriConfig)
    ↓
✅ App ready with live credentials
```

## Additional Commands

```bash
# Generate or update configuration from BWS
make generate-config

# Validate that configuration exists
make validate-config

# Show available commands
make help
```

## Git Configuration and Secrets Protection

### Files to NEVER Commit

The following files are **always GITIGNORED** and contain your real credentials:

```
lib/config/aiuri_config_generated.dart    ← Generated with real secrets
```

### Verification

To verify the file is properly ignored:

```bash
# This should return nothing (meaning it's ignored):
git status lib/config/aiuri_config_generated.dart

# This should show the file is in .gitignore:
grep -r "aiuri_config_generated" .gitignore
```

If you accidentally committed these files:

```bash
# Remove from Git history:
git rm --cached lib/config/aiuri_config_generated.dart
git commit -m "chore: remove committed secrets"

# The file will remain on your local disk but won't be tracked
```

## Troubleshooting

### "Configuration file not found"
```bash
# Make sure you've run:
make generate-config
```

### "Invalid Bitwarden token"
```bash
# Check your token is set:
echo $BWS_ACCESS_TOKEN

# If empty, add to ~/.zshrc or ~/.bashrc:
export BWS_ACCESS_TOKEN="your_token_here"
```

### "AiuriSDK not initialized"
```bash
# Check that main.dart calls:
await AiuriSDK.initialize(aiuriConfig);
# before runApp()
```
