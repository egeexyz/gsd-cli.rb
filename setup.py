import os
from setuptools import setup

setup(
    name = 'gsdcli',
    version = '0.1.3',
    description = 'A cli for installing game servers',
    license='MIT',
    author = 'Egee',
    packages = ['gsdcli'],
    entry_points = {
        'console_scripts': [
            'gsd-cli=gsdcli.gsdcli:gsdcli']
            }
)