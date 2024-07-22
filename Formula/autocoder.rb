class Autocoder < Formula
  desc "Autocoder is a CLI utility for running autonomous projects programming on local environment"
  homepage "https://github.com/marcinsdance/autocoder"
  license "MIT"
  version "0.0.5"
  url "https://github.com/marcinsdance/autocoder/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "10c990c19267ebfb39a8eb749728f0c1e4c27590431f673d9c2505ffac0dc888"
  head "https://github.com/marcinsdance/autocoder.git", :branch => "master"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Autocoder is an AI-powered coding assistant for automating programming tasks.
      You will need to have an LLM like OpenAI or Claude API key to use Autocoder effectively.

      To start using Autocoder, run:
        autocoder init

      This command will guide you through the initial setup, including entering your
      OpenAI API key and configuring your preferences.

      To get a list of available commands, run:
        autocoder --help

      For more detailed information on how to use Autocoder, please refer to the
      documentation available at:
      https://github.com/marcinsdance/autocoder/blob/master/README.md

      If you encounter any issues or have questions, please visit the GitHub
      repository at https://github.com/marcinsdance/autocoder for support.
    EOS
  end
end

