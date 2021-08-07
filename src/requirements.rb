# frozen_string_literal: true

class Requirements
  def install!
    install_brew!
  end

  private

  def install_brew!
    unless Brew.installed?
      Brew.install!
    end
  end
end
