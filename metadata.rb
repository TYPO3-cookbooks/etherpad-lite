name             "etherpad-lite"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures etherpad-lite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.1"

depends "build-essential", "~> 2.0.6"
depends "database", "~> 2.3.0"
depends "git", "~> 4.0.2"
depends "mysql", "~> 5.5.2"
depends "nodejs", "~> 2.1.0"
depends "nginx", "~> 2.7.4"
