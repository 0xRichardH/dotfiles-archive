# frozen_string_literal: true

class Prerequirement
  attr_reader :dotfiles_dir, :dotfiles_local_dir

  def initialize(dotfiles_dir:, dotfiles_local_dir:)
    @dotfiles_dir = dotfiles_dir
    @dotfiles_local_dir = dotfiles_local_dir
  end

  def check!
    if any_repo_existed?
      raise "The `#{dotfiles_dir}` or `#{dotfiles_local_dir}` is existed. Please install dotfiles manually or remove the existing folders and continue the install process."
    end
  end

  private

  def any_repo_existed?
    File.directory?(dotfiles_dir) || File.directory?(dotfiles_local_dir)
  end
end
