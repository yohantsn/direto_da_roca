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

##Generating the Keys Class
The project uses a script to fetch secrets from Bitwarden and generate a native Dart class located at core_sdk/repository/secrets/app_keys.dart.

To generate or update your local keys, run:

```Bash
make generate-keys
```
The generated file will follow this structure:

```Dart

// GENERATED CODE - DO NOT MODIFY BY HAND
class AppKeys {
  static const String supabaseUrl = '[https://your-project.supabase.co](https://your-project.supabase.co)';
  static const String supabaseAnonKey = 'your-anon-key';
}
```

[!CAUTION] Security Warning: The app_keys.dart file contains plain-text credentials and must never be committed to the repository. It is included in the .gitignore by default.

Development Workflow
Update a secret value in the Bitwarden Web UI.

Run make generate-keys in your terminal.

The Flutter application will immediately use the updated values through the AppKeys class.