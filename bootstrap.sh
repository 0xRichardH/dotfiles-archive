#!/usr/bin/env ruby

require_relative "./src/install_rcm"

RCM_VERSION = "1.3.4".freeze

puts "-> 1. Clone thoughtbot/dotfiles onto the machine"
system "git clone git://github.com/thoughtbot/dotfiles.git ~/dotfiles"

puts "-> 2. Clone haoxilu/dotfiles-local onto the machine"
system "git clone git://github.com/haoxilu/dotfiles-local.git ~/dotfiles-local"

puts "-> 3. Install rcm"
InstallRcm.new(version: RCM_VERSION).install!

# Run rcup
