"""Script to get the latest settings and update the repository accordingly."""

import helper.sys_helper as sh
import helper.vscode_helper as code


def update():
    """Update the repository with the latest settings."""
    if code.vscode_installed():
        sh.clear_console()
        code.update_settings()


if __name__ == "__main__":
    update()
