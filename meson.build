project('com.github.arkaitzsilva.vaults', 'vala', 'c')

add_project_arguments(['-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name())], language: 'c')

i18n = import('i18n')
gnome = import('gnome')
gresource = gnome.compile_resources(
    'as-resources', 'data/com.github.arkaitzsilva.vaults.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

subdir('src')

dependencies = [
    dependency('gtk+-3.0'),
    dependency('granite'),
    dependency('glib-2.0')
]

executable(
	meson.project_name(),
	sources,
	dependencies: dependencies,
	install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')
