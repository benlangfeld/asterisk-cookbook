# develop
  * Enable installation of Certified Asterisk.
  * Allow passing configuration attributes to install from source.
  * Allow enabling/disabling build options

# 1.1.1
  * Attribute typo in template

# 1.1.0
  * Add support for Ubuntu 14.04
  * Add support for Fedora
  * Make sure sox is installed.
  * Use correct lib_dir on RHEL/Fedora platforms, where lib != lib64
  * Use EPEL packages to install Asterisk by default
  * Fix a broken guard to allow installation from upstream packages

# 1.0.0
  * Unlock dependency on build-essential for broader compatibility
  * Update unimrcp dependency to stable release

# 0.3.0
  * CentOS support

# 0.2.7
  * Use UniMRCP cookbook to install UniMRCP and its Asterisk modules

# 0.2.6
  * Ensure sox is installed for mixing recordings

# 0.2.5
  * Allow configuring AMI event filters via attributes

# 0.2.4
  * Install latest Asterisk from source

# 0.2.3
  * Don't recompile UniMRCP after it's already successfully built

# 0.2.2
  * More sensible IP address attribute defaults

# 0.2.1
  * Fix and test building SIP peers and dialplan contexts from databags without search

# 0.2.0
  * Better testing and documentation
  * No longer test on CentOS until someone asks for it
  * Build in same directories for Package and Source installs
  * Fix builds, including UniMRCP

# 0.1.0
  * First release
