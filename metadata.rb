maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures etherpad-lite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.2"

%w{
build-essential
database
git
mysql
nodejs
npm
nginx
ssl_certificates
}.each do |cb|
  depends cb
end