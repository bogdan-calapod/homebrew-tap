class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.11/pdq-macos-arm64"
      sha256 "295b57e963d2d70911a6a31f4427ff985001394f17cd1e0997036919a603adc7"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.11/pdq-macos-x64"
      sha256 "f9adb141a0eae9d05bc7ffef96ee3d1215aa384a4a7c4465a5a8dbf99174b4f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.11/pdq-linux-arm64"
      sha256 "cbfa28f94d473581368678845302c9b64865d719740575963fe4b0a51054c9a9"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.11/pdq-linux-x64"
      sha256 "cc040f66484373b0e7a3be302489bfed5888c2f13a38bf4201ddd02301d5fdd8"
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
