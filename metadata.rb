name             "etherpad-lite"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures etherpad-lite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue '0.0.1'

depends "build-essential", "< 5.0.0"
depends "database", "~> 1.3.12"
depends "git"
depends "mysql", "= 1.3.0"
depends "nodejs", "= 3.0.0"
depends "chef_nginx"
depends "systemd", "= 2.1.3"
