import setuptools

setuptools.setup(
    name='manage-color',
    version='0.3.0',
    description='preview color schemes in your terminal and setup',
    author='tetutaro',
    author_email='tetsutaro.maruyama@gmail.com',
    url='https://github.com/tetutaro/dotfiles/color_scheme',
    license='MIT',
    packages=['manage_color'],
    entry_points={
        'console_scripts': ['manage-color=manage_color:main']
    },
)
