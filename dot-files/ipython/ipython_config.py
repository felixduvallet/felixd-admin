# Configuration file for ipython.
# Author: Felix Duvallet, June 2015.

c = get_config()
c.InteractiveShellApp.exec_lines = []

# Always turn on autoreload extension.
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2')

# Load numpy and pyplot by default.
c.InteractiveShellApp.exec_lines.append('import matplotlib.pyplot as plt')
c.InteractiveShellApp.exec_lines.append('import numpy as np')
