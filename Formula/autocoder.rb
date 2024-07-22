class Autocoder < Formula
  include Language::Python::Virtualenv

  desc "CLI utility for running autonomous projects programming on local environment"
  homepage "https://github.com/marcinsdance/autocoder"
  url "https://github.com/marcinsdance/autocoder/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "10c990c19267ebfb39a8eb749728f0c1e4c27590431f673d9c2505ffac0dc888"
  license "MIT"
  head "https://github.com/marcinsdance/autocoder.git", branch: "master"

  depends_on "python@3.12"

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/bc/57/e84d88dfe0aec03b7a2d4327012c1627ab5f03652216c63d49846d7a6c58/python-dotenv-1.0.1.tar.gz"
    sha256 "e324ee90a023d808f1959c46bcbc04446a10ced277783dc6ee09987c37ec10ca"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "openai" do
    url "https://files.pythonhosted.org/packages/20/49/df107c1171607610e8f02036971da528e004979dbd04875b2bed9144bc9a/openai-1.36.1.tar.gz"
    sha256 "41be9e0302e95dba8a9374b885c5cb1cec2202816a70b98736fee25a2cadd1f2"
  end

  resource "anthropic" do
    url "https://files.pythonhosted.org/packages/6a/78/3f8a617187b607e78689b03e063b4fb75dd6bd9ea9df365ec1273e44a06f/anthropic-0.31.2.tar.gz"
    sha256 "0134b73df8d1f142fc68675fbadb75e920054e9e3437b99df63f10f0fc6ac26f"
  end

  resource "langgraph" do
    url "https://files.pythonhosted.org/packages/de/8b/fd60e796226a9d3dba8914cc6690afa3f3de1643f7937834a1785cea43bd/langgraph-0.0.38.tar.gz"
    sha256 "c13ce73c4764787e31f20854ebae505140ee5b750e8ba07c29e45969ce591c7b"
  end

  resource "astor" do
    url "https://files.pythonhosted.org/packages/5a/21/75b771132fee241dfe601d39ade629548a9626d1d39f333fde31bc46febe/astor-0.8.1.tar.gz"
    sha256 "6a6effda93f4e1ce9f618779b2dd1d9d84f1e32812c23a29b3fff6fd7f63fa5e"
  end

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

  test do
    assert_match "Autocoder", shell_output("#{bin}/autocoder --help")
  end
end