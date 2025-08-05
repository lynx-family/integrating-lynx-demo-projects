#!/usr/bin/env python3
# Copyright 2025 The Lynx Authors. All rights reserved.
# Licensed under the Apache License Version 2.0 that can be found in the
# LICENSE file in the root directory of this source tree.

import argparse
import re


def replace_pod_version(component, version, podfile):
    pattern = re.compile(r"pod\s+['\"](\S+)['\"]\s*,\s*['\"]([~>\d.\-a-zA-Z]+)['\"]")
    replace_pattern = re.compile(
        rf"(pod\s+['\"]{re.escape(component)}['\"]\s*,\s*['\"])([\d.-a-zA-Z]+)(['\"])",
        re.MULTILINE
    )
    
    success_write = 0
    with open(podfile, 'r', encoding='utf8') as f:
        content = f.read()
    results = pattern.findall(content)
    for res in results:
        if res[0] == component:
            content = replace_pattern.sub(rf"\g<1>{version}\3", content)
            success_write = 1
        
    with open(podfile, 'w') as f:
        f.write(content)
        
    if success_write:
        print(f"Successfully wrote the new version {version} of {component} to {podfile} ")
    else:
        print(f"Failed to write the new version {version} of {component} to {podfile} ")


def main():
    """
    usage: 'python3 replace_pod_version.py --component <component> --version <version> --podfile <podfile_path>'
    like : python3 replace_pod_version.py  --component Lynx --version 3.4.0 --podfile ios/HelloLynxObjc/Podfile
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--component', type=str, help='the component need to be processed', required=True)
    parser.add_argument('--version', type=str, help='the component version', required=True)
    parser.add_argument('--podfile', type=str, help='the pod file', required=True)
   

    args = parser.parse_args()
    if args.component and args.version: 
        replace_pod_version(args.component, args.version, args.podfile)
    else:
        print('Please specify --component, --version, --podfile')
        exit(1)


if __name__ == '__main__':
    main()
