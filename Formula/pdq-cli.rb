class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.10/pdq-macos-arm64"
      sha256 "51525f88cc826d063567f0f4ba5127340889a8754969c0f4e2a911ea1d67ddf9"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.10/pdq-macos-x64"
      sha256 "fdfb4410e25a887c239ff7f118c352bbb2034df122f0b6eb119b8617168d73f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.10/pdq-linux-arm64"
      sha256 "ef83d79090dc22d9e48933291fd68f403e708e9a86447ef288216e0d93cf4eb9"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.10/pdq-linux-x64"
      sha256 "923c0eac040b369aa7a6cbc46b8ee761af1561f4d8241bd6729ae479efeb96c4"
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
