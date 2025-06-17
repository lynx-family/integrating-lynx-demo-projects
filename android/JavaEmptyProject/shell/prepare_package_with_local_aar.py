import os
import shutil
import sys
import zipfile

from utils import ConfigFileEntity

def reset_directory(target_dir):
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir)
    os.makedirs(target_dir, exist_ok=True)

def unzip_maven_repository(zip_file_path, target_dir):
    temp_dir = None
    try:
        reset_directory(target_dir)
        with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
            temp_dir = os.path.join(os.path.dirname(zip_file_path), "temp_unzip")
            zip_ref.extractall(temp_dir)
            
            for root, _, files in os.walk(temp_dir):
                for file in files:
                    src_file = os.path.join(root, file)
                    
                    rel_path = os.path.relpath(src_file, temp_dir)
                    dst_file = os.path.join(target_dir, rel_path)
                    
                    dst_dir = os.path.dirname(dst_file)
                    os.makedirs(dst_dir, exist_ok=True)
                    
                    shutil.copy2(src_file, dst_file)
            
            shutil.rmtree(temp_dir)
            print(f"Successfully prepared local maven repository at {target_dir}")
            
    except Exception as e:
        print(f"Prepare local maven repository failed: {e}")
        if temp_dir and os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)
        raise e

def main():
    argv = sys.argv
    print(argv)
    if len(argv) < 3:
        raise RuntimeError("invalid parameters")
    zip_file_path = argv[1]
    version = argv[2]
    script_dir = os.path.dirname(__file__)
    unzip_maven_repository(zip_file_path, os.path.join(script_dir, "../local-maven"))
    config_file_entity = ConfigFileEntity('app/build.gradle', os.path.join(os.path.dirname(__file__), '..'))
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx:.*"', f'    implementation "org.lynxsdk.lynx:lynx:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-base:.*"', f'    implementation "org.lynxsdk.lynx:lynx-base:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-jssdk:.*"', f'    implementation "org.lynxsdk.lynx:lynx-jssdk:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-trace:.*"', f'    implementation "org.lynxsdk.lynx:lynx-trace:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-service-image:.*"', f'    implementation "org.lynxsdk.lynx:lynx-service-image:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-service-log:.*"', f'    implementation "org.lynxsdk.lynx:lynx-service-log:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-service-http:.*"', f'    implementation "org.lynxsdk.lynx:lynx-service-http:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-devtool:.*"', f'    implementation "org.lynxsdk.lynx:lynx-devtool:{version}"')
    config_file_entity.add_replace_item(r'\s*implementation "org.lynxsdk.lynx:lynx-service-devtool:.*"', f'    implementation "org.lynxsdk.lynx:lynx-service-devtool:{version}"')
    config_file_entity.open_and_change_line()

if __name__ == '__main__':
    sys.exit(main())
