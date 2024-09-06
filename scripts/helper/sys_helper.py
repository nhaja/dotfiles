import sys
import os

from shutil import copyfile


def copy(src, dst):
    '''Copy file from src to dist'''
    copyfile(src, dst)

def clear_console():
    os.system('cls' if sys.platform == 'win32' else 'clear')