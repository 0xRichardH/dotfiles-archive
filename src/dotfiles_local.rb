# frozen_string_literal: true

class DotfilesLocal
  include Common

  attr_reader :repo, :path

  def initialize(repo:, path:)
    @repo = repo
    @path = path
  end

  def clone!
    branch = linux? ? :linux : :master

    Git.new(branch: branch, repo: repo, path: path).clone!
  end
end
