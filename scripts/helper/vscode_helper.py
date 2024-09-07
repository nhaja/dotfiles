"""Helper functions for VSCode settings management"""

import os
import sys

import helper.sys_helper as sh

VSCODE_SETTINGS_REPO_PATH = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), os.pardir, os.pardir, "vscode"
)


def vscode_installed() -> bool:
    installed = os.path.exists(get_vscode_settings_path())
    assert installed, "VSCode is not installed"
    return installed


def get_vscode_settings_path():
    if sys.platform == "win32":
        return os.path.join(os.getenv("APPDATA"), "Code", "User")
    elif sys.platform == "darwin":
        return os.path.join(
            os.getenv("HOME"), "Library", "Application Support", "Code", "User"
        )
    elif sys.platform == "linux":
        return os.path.join(os.getenv("HOME"), ".config", "Code", "User")


def get_vscode_extensions_path():
    if sys.platform == "win32":
        return os.path.join(os.getenv("USERPROFILE"), ".vscode", "extensions")
    elif sys.platform == "darwin":
        return os.path.join(os.getenv("HOME"), ".vscode", "extensions")
    elif sys.platform == "linux":
        return os.path.join(os.getenv("HOME"), ".vscode", "extensions")


def update_vscode_settings(src, dst):
    vscode_files = ["settings.json", "keybindings.json"]
    print(f"Copying vscode settings files from {src} to {dst}:")
    for file in vscode_files:
        print(f"\t- {file}", end="")
        sh.copy(src=os.path.join(src, file), dst=os.path.join(dst, file))
        print(" [OK]")


def update_settings():
    src = get_vscode_settings_path()
    dst = VSCODE_SETTINGS_REPO_PATH
    update_vscode_settings(src=src, dst=dst)
    print("VSCode settings updated")


def install_settings():
    src = VSCODE_SETTINGS_REPO_PATH
    dst = get_vscode_settings_path()
    update_vscode_settings(src=src, dst=dst)
    print("VSCode settings installed")


if __name__ == "__main__":
    assert (
        len(sys.argv) == 0
    ), 'No argument provided, please use either "update" or "install"'
    assert (
        len(sys.argv) > 1
    ), 'Too many arguments provided, please use either "update" or "install"'
    if sys.argv[1] == "update":
        update_settings()
    if sys.argv[1] == "install":
        install_settings()
