import os
import re


class ConfigFileEntity:
    def __init__(self, target_file, workspace_dir):
        self.target_file = target_file
        self.workspace_dir = workspace_dir
        self.replace_map = {}

    def add_replace_item(self, key, value):
        self.replace_map[key] = value

    def open_and_change_line(self):
        content = ''
        with open(os.path.join(self.workspace_dir, self.target_file), 'r') as file:
            for line in file:
                replace = False
                for search_line in self.replace_map:
                    if re.match(search_line, line) is not None:
                        content = content + self.replace_map[search_line] + "\n"
                        replace = True
                        break
                if not replace:
                    content = content + line
        with open(os.path.join(self.workspace_dir, self.target_file), 'w') as file:
            file.write(content)