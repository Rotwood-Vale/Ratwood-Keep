import re
import os

def replace_spans_in_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    pattern = re.compile(r'"<span class=\'(.*?)\'>(.*?)<\/span>"')

    def replace_span(match):
        class_names = match.group(1).replace(' ', '')
        span_content = match.group(2)
        return f'span_{class_names}("{span_content}")'

    result = pattern.sub(replace_span, content)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(result)

def process_dm_files_in_directory(directory_path):
    for root, _, files in os.walk(directory_path):
        for file_name in files:
            if file_name.endswith('.dm'):
                file_path = os.path.join(root, file_name)
                replace_spans_in_file(file_path)
                print(f"Processed {file_path}")

# Uncomment to run :)
# directory_path = '.' 
# process_dm_files_in_directory(directory_path)
# print("All .dm files have been processed successfully.")
