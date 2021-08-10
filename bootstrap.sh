#!/usr/bin/env ruby

require_relative "./src/command"
require_relative "./src/brew"
require_relative "./src/prerequirement"
require_relative "./src/requirements"
require_relative "./src/git"
require_relative "./src/dotfiles_local"
require_relative "./src/plugins"
require_relative "./src/rcm"
require_relative "./src/rcup"


RCM_VERSION = "1.3.4".freeze
HOME_PATH = ENV["HOME"].freeze
DOTFILES_DIR = File.join(HOME_PATH,"dotfiles").freeze
DOTFILES_LOCAL_DIR = File.join(HOME_PATH, "dotfiles-local").freeze
DOTFILES_GIT_REPO = "git://github.com/thoughtbot/dotfiles.git".freeze
DOTFILES_LOCAL_GIT_REPO = "git://github.com/haoxilu/dotfiles-local.git".freeze

ENV["CI"] = "true"

# Pre-check
puts "-> 0. Pre-checking"
Prerequirement.new(dotfiles_dir: DOTFILES_DIR, dotfiles_local_dir: DOTFILES_LOCAL_DIR).check!

puts "-> 1. Install the system requirements."
Requirements.new.install!

puts "-> 2. Clone thoughtbot/dotfiles onto the machine"
Git.new(repo: DOTFILES_GIT_REPO, path: DOTFILES_DIR).clone!

puts "-> 3. Clone haoxilu/dotfiles-local onto the machine"
DotfilesLocal.new(repo: DOTFILES_LOCAL_GIT_REPO, path: DOTFILES_LOCAL_DIR).clone!

puts "-> 4. Setup Plugins"
Plugins.new(local: DOTFILES_LOCAL_DIR, home: HOME_PATH).install!

puts "-> 5. Install rcm"
Rcm.new(version: RCM_VERSION).install!

puts "-> 6. Create symlinks for config files in your home director"
Rcup.new(dotfiles_dir: DOTFILES_DIR, dotfiles_local_dir: DOTFILES_LOCAL_DIR).execute!
