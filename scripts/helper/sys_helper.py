"""Helper functions for system operations"""

import os
import sys
from shutil import copyfile


def copy(src, dst):
    copyfile(src, dst)


def clear_console():
    os.system("cls" if sys.platform == "win32" else "clear")
