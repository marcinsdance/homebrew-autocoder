
class Autocoder < Formula
  desc "Autocoder is a CLI utility for running autonomous projects programming on local environment"
  homepage "https://github.com/marcinsdance/autocoder"
  license "MIT"
  version "0.0.1"
  url "https://github.com/marcinsdance/autocoder/archive/refs/tags/0.0.1.tar.gz"
  sha256 "5d82208198645636f81b0d84313f38c52356d58cbe474e2a51fbf7d5c074cd8b"
  head "https://github.com/marcinsdance/autocoder.git", :branch => "master"

  depends_on "python@3.12"

  def install
    prefix.install Dir["*"]
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

