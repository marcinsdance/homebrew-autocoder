class Autocoder < Formula
  include Language::Python::Virtualenv

  desc "CLI utility for running autonomous projects programming on local environment"
  homepage "https://github.com/marcinsdance/autocoder"
  url "https://github.com/marcinsdance/autocoder/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "10c990c19267ebfb39a8eb749728f0c1e4c27590431f673d9c2505ffac0dc888"
  license "MIT"
  head "https://github.com/marcinsdance/autocoder.git", branch: "master"

  depends_on "python@3.12"
  depends_on "rust" => :build

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

  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/df/db/f35a00659bc03fec321ba8bce9420de607a1d37f8342eee1863174c69557/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/8c/99/d0a5dca411e0a017762258013ba9905cd6e7baa9a3fd1fe8b6529472902e/pydantic-2.8.2.tar.gz"
    sha256 "6f62c13d067b0755ad1c21a34bdd06c0c12625a22b0fc09c6b149816604f7c2a"
  end

  resource "annotated_types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end

  resource "pydantic_core" do
    url "https://files.pythonhosted.org/packages/12/e3/0d5ad91211dba310f7ded335f4dad871172b9cc9ce204f5a56d76ccd6247/pydantic_core-2.20.1.tar.gz"
    sha256 "26ca695eeee5f9f1aeeb211ffc12f10bcb6f71e2989988fda61dabd65db878d4"
  end

  def install
    # Create a virtual environment in the libexec
    venv = virtualenv_create(libexec, "python3.12")

    # Use the pip from the Python installation that Homebrew provides
    pip = Formula["python@3.12"].opt_bin/"pip3"

    # Upgrade pip and install wheel
    system pip, "install", "--upgrade", "pip"
    system pip, "install", "wheel"

    # Install all resources
    resources.each do |r|
      r.stage do
        system pip, "install", "."
      end
    end

    # Install the package itself
    system pip, "install", "-v", "--ignore-installed", buildpath

    # Create a wrapper script
    (bin/"autocoder-wrapper").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/lib/python3.12/site-packages:$PYTHONPATH"
      exec "#{libexec}/bin/python" "#{libexec}/bin/autocoder" "$@"
    EOS

    # Make the wrapper script executable
    chmod 0755, bin/"autocoder-wrapper"

    # Create a symlink with the original name
    bin.install_symlink "autocoder-wrapper" => "autocoder"
  end

  test do
    assert_match "Autocoder", shell_output("#{bin}/autocoder --help")
  end
end