class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.8/pdq-macos-arm64"
      sha256 "9567a7b33ed60bb9552c9c01e34c5ca6b80e4fe2db2487a371fd540fb2f7f501"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.8/pdq-macos-x64"
      sha256 "c6720ef41d7abf841a06330b9bae06b8c5f4f3209c99b1fc23cd5b38ee0eab66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.8/pdq-linux-arm64"
      sha256 "22216d2c1c4ae6954439c5202562da5873990c220bffe9c69b898a547115ed9b"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.8/pdq-linux-x64"
      sha256 "f537cb0ea87f75cb9f6c1afdedfb0b8074bfe8633412c48dc61d70b4eea62878"
    end
  end

  def install
    binary_name = "pdq-macos-arm64" if OS.mac? && Hardware::CPU.arm?
    binary_name = "pdq-macos-x64" if OS.mac? && Hardware::CPU.intel?
    binary_name = "pdq-linux-arm64" if OS.linux? && Hardware::CPU.arm?
    binary_name = "pdq-linux-x64" if OS.linux? && Hardware::CPU.intel?

    bin.install binary_name => "pdq"
  end

  test do
    assert_match "pdq-cli", shell_output("#{bin}/pdq --version")
  end
end
