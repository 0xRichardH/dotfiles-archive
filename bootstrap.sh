#!/usr/bin/env ruby

require_relative "./src/install_rcm"

RCM_VERSION = "1.3.4".freeze
DOTFILES = "~/dotfiles".freeze
DOTFILES_LOCAL = "~/dotfiles-local".freeze

puts "-> 1. Clone thoughtbot/dotfiles onto the machine"
system "git clone git://github.com/thoughtbot/dotfiles.git #{DOTFILES}"

puts "-> 2. Clone haoxilu/dotfiles-local onto the machine"
system "git clone git://github.com/haoxilu/dotfiles-local.git #{DOTFILES_LOCAL}"

puts "-> 3. Install rcm"
InstallRcm.new(version: RCM_VERSION).install!

puts "-> 4. Create symlinks for config files in your home director"
system "env RCRC=$HOME/dotfiles/rcrc rcup"
