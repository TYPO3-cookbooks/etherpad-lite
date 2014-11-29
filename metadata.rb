name             "etherpad-lite"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures etherpad-lite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.3"

depends "build-essential"
depends "database", "~> 1.3.12"
depends "git", "~> 0.9.0"
depends "mysql", "= 1.3.0"
depends "nodejs", "= 2.2.0"
depends "nginx", "= 1.6.0"
