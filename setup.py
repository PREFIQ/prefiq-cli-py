from setuptools import setup

setup(
    name='prefiq-cli-py',
    version='0.1',
    py_modules=['cli'],
    entry_points={
        'console_scripts': [
            'prefiq=cli:main',
        ],
    },
)
