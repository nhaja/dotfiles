import os
import sys

import helper.helper as helper

def update_vscode_settings():
    vscode_files = ['settings.json', 'keybindings.json']
    vscode_sys_settings_path = helper.get_vscode_settings_path()
    vscode_repo_settings_path = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), 
        os.pardir, 
        'vscode')

    print(vscode_repo_settings_path)
    print(f'Copying vscode settings files from {vscode_sys_settings_path} to '
          f'{vscode_repo_settings_path}:')
    for file in vscode_files:
        print(f'\t- {file}', end='')
        src = os.path.join(vscode_sys_settings_path, file)
        dst = os.path.join(vscode_repo_settings_path, file)
        helper.copy(src, dst)
        print(' [OK]')

def update():
    if helper.vscode_installed():
        update_vscode_settings()

def main():
    update()

if __name__ == '__main__':
    main()