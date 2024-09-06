import os
import sys

import helper.vscode_helper as code
import helper.sys_helper as sh 

def update():
    if code.vscode_installed():
        sh.clear_console()
        code.update_settings()

def main():
    update()

if __name__ == '__main__':
    main()