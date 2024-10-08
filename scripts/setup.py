import helper.sys_helper as sh
import helper.vscode_helper as code


def setup():
    """Copy files to VSCode install directory"""
    if code.vscode_installed():
        sh.clear_console()
        code.install_settings()

if __name__ == "__main__":
    setup()