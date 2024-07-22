
class Autocoder < Formula
  desc "Autocoder is a CLI utility for running autonomous projects programming on local environment"
  homepage "https://github.com/marcinsdance/autocoder"
  license "MIT"
  version "0.0.3"
  url "https://github.com/marcinsdance/autocoder/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "74c19f000898ec9b2941bafae505830eae5922c30151830e69bbbd66ef82b184"
  head "https://github.com/marcinsdance/autocoder.git", :branch => "master"

  depends_on "python@3.12"


  def install
    venv = virtualenv_create(prefix, "python3")
    venv.pip_install_and_link buildpath

    # Install the main script from the correct location
    bin.install "src/autocoder/autocoder.py" => "autocoder"

    # Modify the shebang of the installed script to use the virtualenv python
    inreplace bin/"autocoder", "#!/usr/bin/env python3", "#!#{venv.binary("python3")}"
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

