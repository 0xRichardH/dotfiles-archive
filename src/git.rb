# frozen_string_literal: true

class Git
  attr_reader :branch, :repo, :path

  def initialize(branch: nil, repo:, path:)
    @branch = branch
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
    if branch.nil?
      Command.new("git clone #{repo} #{path}").run!
    else
      Command.new("git clone -b #{branch} #{repo} #{path}").run!
    end
  end
end
