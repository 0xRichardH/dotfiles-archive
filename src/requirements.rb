# frozen_string_literal: true

class Requirements
  def install!
    switch_to_zsh!
  end

  private

  def switch_to_zsh!
    unless system("which zsh")
      system "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"", exception: true
    end

    system("zsh", exception: true)
  end
end
