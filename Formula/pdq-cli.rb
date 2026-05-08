class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.7/pdq-macos-arm64"
      sha256 "81224e427589a21004c233b2dd6bf5116345da34521b4e260a407586b05b6733"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.7/pdq-macos-x64"
      sha256 "1b9302928d9a803beb41f3a911b2b0a699702e0bda085a43f316c1160666faef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.7/pdq-linux-arm64"
      sha256 "3b932b0d3d2397a712316e07d0d224f84edc892cd388e13aa36f14f92e177bed"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.7/pdq-linux-x64"
      sha256 "febcae54d867461dd909e31edee2a731ee57f68032bcb548b16820fa1366c0ee"
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
