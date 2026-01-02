import json
import sys
import os

def to_camel_case(text):
    content = text.lower().replace('-', '_').split('_')
    return content[0] + ''.join(x.title() for x in content[1:])

def generate():
    try:
        input_data = sys.stdin.read()
        if not input_data:
            print("Error: any data received from BWS")
            return

        secrets = json.loads(input_data)
        
        if not isinstance(secrets, list):
            secrets = [secrets]

        output_dir = "core_sdk/repository/lib/src/secrets"
        os.makedirs(output_dir, exist_ok=True)
        output_path = os.path.join(output_dir, "app_keys.dart")

        lines = [
            "//CREATED AUTOMATICALLY, DON'T CHANGED IT!!!",
            "class AppKeys {"
        ]

        for s in secrets:
            key_name = to_camel_case(s.get('key', 'unknown'))
            value = s.get('value', '')
            lines.append(f"  static const String {key_name} = '{value}';")

        lines.append("}")

        with open(output_path, "w") as f:
            f.write("\n".join(lines))
        
        print(f"Success! {len(secrets)} the keys was generated in {output_path}")

    except Exception as e:
        print(f" Error: {e}")

if __name__ == "__main__":
    generate()