#!/usr/bin/env python3
"""
Generate AiuriSDKConfig implementation from BWS secrets.

This script reads secrets from Bitwarden Secrets Manager via stdin
and generates a Dart class that implements AiuriSDKConfig interface.

Usage:
    bws secret list | python3 generate_keys.py

Output:
    lib/config/aiuri_config_generated.dart
"""

import json
import sys
import os
from datetime import datetime


def extract_credentials(secrets):
    """Extract Supabase credentials from BWS secrets list."""
    config = {
        'DATABASE_URL': '',
        'DATABASE_ANON_KEY': '',
    }
    
    for secret in secrets:
        key = secret.get('key', '').upper()  # Convert to UPPERCASE for matching
        value = secret.get('value', '').strip()
        
        if not key or not value:
            continue
        
        # Match common key names (case-insensitive)
        if 'DATABASE' in key and 'URL' in key:
            config['DATABASE_URL'] = value
        elif 'DATABASE' in key and 'ANON' in key:
            config['DATABASE_ANON_KEY'] = value
    
    return config


def generate_dart_class(credentials):
    """Generate Dart class that implements AiuriSDKConfig."""
    timestamp = datetime.now().isoformat()
    
    # Escape quotes in credentials
    url = credentials['DATABASE_URL'].replace("'", "\\'")
    anon_key = credentials['DATABASE_ANON_KEY'].replace("'", "\\'")
    
    dart_code = '''// GENERATED FILE - DO NOT MODIFY MANUALLY
// This file was auto-generated from BWS (Bitwarden Secrets Manager)
// Generated at: {timestamp}
// To regenerate: bws secret list | python3 generate_keys.py

import 'package:aiuri_sdk/aiuri_sdk.dart';

/// Auto-generated Supabase configuration
/// Implements the AiuriSDKConfig interface from aiuri_sdk package
class GeneratedAiuriConfig implements AiuriSDKConfig {{
  @override
  final String supabaseUrl;

  @override
  final String supabaseAnonKey;

  GeneratedAiuriConfig({{
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  }});

  @override
  String toString() => 'GeneratedAiuriConfig(url: $supabaseUrl)';
}}
'''.format(
        timestamp=timestamp,
    )
    
    # Add the credentials at the bottom
    dart_code += f'\n// ============= GENERATED INSTANCE =============\n\n'
    dart_code += f'''/// Pre-configured instance with your Supabase credentials
/// Use this directly in main.dart:
///   await AiuriSDK.initialize(aiuriConfig);
final aiuriConfig = GeneratedAiuriConfig(
  supabaseUrl: '{url}',
  supabaseAnonKey: '{anon_key}',
);
'''
    
    return dart_code


def generate():
    """Main generation function."""
    try:
        input_data = sys.stdin.read()
        if not input_data:
            print("❌ Error: no data received from BWS")
            print("Usage: bws secret list | python3 generate_keys.py")
            return 1

        secrets = json.loads(input_data)
        if not isinstance(secrets, list):
            secrets = [secrets]

        # Extract credentials from secrets
        credentials = extract_credentials(secrets)

        # Debug: Show what we found
        print(f"🔍 Debug:")
        print(f"   Found: DATABASE_URL: {bool(credentials['DATABASE_URL'])}")
        print(f"   Found: DATABASE_ANON_KEY: {bool(credentials['DATABASE_ANON_KEY'])}")
        print("")

        # Validate
        if not credentials['DATABASE_URL']:
            print("❌ Error: DATABASE_URL not found in BWS secrets")
            print("   Check your secret keys contain 'DATABASE_URL'")
            return 1
        if not credentials['DATABASE_ANON_KEY']:
            print("❌ Error: DATABASE_ANON_KEY not found in BWS secrets")
            print("   Check your secret keys contain 'DATABASE_ANON_KEY'")
            return 1

        # Create output directory
        output_dir = "lib/config"
        os.makedirs(output_dir, exist_ok=True)
        output_path = os.path.join(output_dir, "aiuri_config_generated.dart")

        # Generate Dart code
        dart_code = generate_dart_class(credentials)

        # Write file
        with open(output_path, "w") as f:
            f.write(dart_code)

        # Print success message
        print("✅ Success! AiuriSDKConfig implementation generated")
        print(f"   📁 File: {output_path}")
        print(f"   🔑 Keys read from BWS: DATABASE_URL, DATABASE_ANON_KEY")
        print("")
        print("📋 Next steps:")
        print('   1. import "config/aiuri_config_generated.dart";')
        print("   2. In main.dart:")
        print("      await AiuriSDK.initialize(aiuriConfig);")
        print("   3. flutter run")
        print("")
        print("⚠️  IMPORTANT:")
        print("   - This file is GITIGNORED (contains real secrets)")
        print("   - Never commit aiuri_config_generated.dart")

        return 0

    except json.JSONDecodeError as e:
        print(f"❌ Error: Invalid JSON from BWS - {e}")
        print("")
        print("🔍 DEBUG: To see what BWS returned, run:")
        print("   bws secret list | python3 -m json.tool")
        return 1
    except Exception as e:
        print(f"❌ Error: {e}")
        print("")
        print("🔍 DEBUG: Run with --show-raw to see raw data")
        return 1


if __name__ == "__main__":
    sys.exit(generate())