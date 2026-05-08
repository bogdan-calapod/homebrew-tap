class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.9/pdq-macos-arm64"
      sha256 "3adfc3d16398ce023d53a721de5c9f61669b7e718a9db7fe290746de6e8a0285"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.9/pdq-macos-x64"
      sha256 "9a1c38c7b621533668eca3530668708e08af2f8a2b1c054af2193b46083d282e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.9/pdq-linux-arm64"
      sha256 "d666480a7f5868deb871b5ed64f790a0fb51fc64b2afb079c6b5026066817530"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.9/pdq-linux-x64"
      sha256 "0cb866d74b802cbf249de3fede1531de0d5cdd11fe769e525874bc0ef7ecfc16"
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
