#
# Cookbook Name:: etherpad-lite
# Attributes:: default

default[:etherpadlite][:proxy][:enable] = true
default[:etherpadlite][:proxy][:hostname] = fqdn
default[:etherpadlite][:proxy][:alias_hostnames] = []
default[:etherpadlite][:proxy][:ssl] = true
default[:etherpadlite][:proxy][:ssl_certificate] = nil

default[:etherpadlite][:listen][:ip] = "127.0.0.1"
default[:etherpadlite][:listen][:port] = 9001

default[:etherpadlite][:database][:host] = "localhost"
default[:etherpadlite][:database][:user] = "etherpadlite"
default[:etherpadlite][:database][:password] = nil
default[:etherpadlite][:database][:name] = "etherpadlite"

default[:etherpadlite][:settings][:defaultPadText] = "Welcome to Etherpad Lite!\\n\\nThis pad text is synchronized as you type, so that everyone viewing this page sees the same text. This allows you to collaborate seamlessly on documents!\\n\\nPlease use this service only for community-related work!\\n\\n"
default[:etherpadlite][:settings][:loglevel] = "INFO"

# either false or the path to abiword binary (e.g. "/usr/bin/abiword")
default[:etherpadlite][:settings][:abiword] = "/usr/bin/abiword"

default[:etherpadlite][:plugins] = {
  'ep_headings' => '0.1.2'
}

# NodeJS
default[:nodejs][:version] = "0.8.7"
default[:nodejs][:install_method] = "source"
default[:nodejs][:checksum] = "fa979488347ad08ea6e36d3fe9c543807cd6f84cad31b22bfc6179b54b1e9d04"

# NodeJS Package Manager (NPM)
default[:npm][:version] = "1.1.52"