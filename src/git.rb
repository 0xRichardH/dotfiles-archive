# frozen_string_literal: true

class Git
  attr_reader :repo, :path

  def initialize(repo:, path:)
    @repo = repo
    @path = path
  end

  def clone!
    if File.directory? path
      puts "Skipped. The folder `#{path}` is existed."
      return
    else
      git_clone!
    end
  end

  private

  def git_clone!
    system "git clone #{repo} #{path}", exception: true
  end
end
