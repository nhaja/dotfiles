import os
import sys
from shutil import copyfile


def vscode_installed() -> bool:
    installed = os.path.exists(get_vscode_settings_path())
    assert installed, 'VSCode is not installed'
    return installed
    
def get_vscode_settings_path():
    if sys.platform == 'win32':
        return os.path.join(os.getenv('APPDATA'), 'Code', 'User')
    elif sys.platform == 'darwin':
        return os.path.join(os.getenv('HOME'), 'Library', 'Application Support', 'Code', 'User')
    elif sys.platform == 'linux':
        return os.path.join(os.getenv('HOME'), '.config', 'Code', 'User')


def copy(src, dst):
    '''Copy file from src to dist'''
    copyfile(src, dst)