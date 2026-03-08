class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.3/pdq-macos-arm64"
      sha256 "33c509f8fc4f7d97f892671aa396e203baff439101d4e3526d289cbc51725525"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.3/pdq-macos-x64"
      sha256 "9116cd04d7c3270137a041154c200a969fe6d6385d37c4a74870135a72fac18a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.3/pdq-linux-arm64"
      sha256 "0e60c3c52f1aa156353f1bf8541b7beaaf5f64984b4da0d481fbf0da4cefd758"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.3/pdq-linux-x64"
      sha256 "c2415e10fded1cb6c8767634cb67669d8a87e5b18199d0f56c0a058885ab6b5c"
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
