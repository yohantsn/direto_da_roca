#!/usr/bin/env python3
"""
Debug script to see what BWS is returning.
Use this if generate_keys.py is failing to find credentials.

Usage:
    python3 debug_bws.py
"""

import json
import sys
import subprocess

def main():
    print("🔍 Debugging BWS connection...\n")
    
    # Step 1: Check if BWS_ACCESS_TOKEN is set
    import os
    token = os.getenv('BWS_ACCESS_TOKEN')
    
    if not token:
        print("❌ BWS_ACCESS_TOKEN is not set!")
        print("\nAdd this to your ~/.zshrc:")
        print('   export BWS_ACCESS_TOKEN="your_token_here"')
        print('   export BWS_IDENTITY_URL="https://identity.bitwarden.eu"')
        print('   export BWS_API_URL="https://api.bitwarden.eu"')
        return 1
    
    print("✅ BWS_ACCESS_TOKEN is set")
    print(f"   Token: {token[:20]}...***\n")
    
    # Step 2: Try to fetch secrets
    print("📡 Fetching secrets from BWS...\n")
    
    try:
        result = subprocess.run(
            ['bws', 'secret', 'list'],
            capture_output=True,
            text=True,
            timeout=10
        )
        
        if result.returncode != 0:
            print(f"❌ BWS command failed with code {result.returncode}")
            print(f"   Error: {result.stderr}")
            return 1
        
        output = result.stdout
        print("✅ Successfully fetched secrets from BWS\n")
        
        # Parse and display
        secrets = json.loads(output)
        
        if not isinstance(secrets, list):
            secrets = [secrets]
        
        print(f"📋 Found {len(secrets)} secrets:\n")
        
        for secret in secrets:
            key = secret.get('key', 'N/A')
            has_value = bool(secret.get('value', ''))
            marker = "✅" if has_value else "⚠️"
            print(f"   {marker} {key}")
        
        # Check for DATABASE credentials
        print("\n🎯 Looking for DATABASE credentials:\n")
        
        found_url = False
        found_anon = False
        
        for secret in secrets:
            key = secret.get('key', '').upper()
            if 'DATABASE' in key and 'URL' in key:
                found_url = True
                print(f"   ✅ DATABASE_URL found")
            if 'DATABASE' in key and 'ANON' in key:
                found_anon = True
                print(f"   ✅ DATABASE_ANON_KEY found")
        
        if not found_url:
            print(f"   ❌ DATABASE_URL NOT found")
        if not found_anon:
            print(f"   ❌ DATABASE_ANON_KEY NOT found")
        
        print("\n" + "="*50)
        if found_url and found_anon:
            print("✅ All required credentials found!")
            print("   You can now run: make generate-config")
            return 0
        else:
            print("❌ Missing credentials in BWS")
            print("   Add DATABASE_URL and DATABASE_ANON_KEY to BWS")
            return 1
        
    except subprocess.TimeoutExpired:
        print("❌ BWS command timed out")
        return 1
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON response: {e}")
        return 1
    except Exception as e:
        print(f"❌ Error: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main())
