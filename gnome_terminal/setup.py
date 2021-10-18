import setuptools

setuptools.setup(
    name='config-gnome-terminal',
    version='0.2.0',
    description='config gnome-terminal via CLI',
    author='tetutaro',
    author_email='tetsutaro.maruyama@gmail.com',
    url='https://github.com/tetutaro/dotfiles/gnome_terminal',
    license='MIT',
    packages=['config_gnome_terminal'],
    entry_points={
        'console_scripts': [
            (
                'set-gnome-terminal-font='
                'config_gnome_terminal.set_font:main'
            ),
            (
                'toggle-gnome-terminal-transparency='
                'config_gnome_terminal.toggle_transparency:main'
            ),
        ]
    },
)
