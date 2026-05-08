class PdqCli < Formula
  desc "CLI for PDQ Connect and PDQ Detect"
  homepage "https://github.com/bogdan-calapod/pdq-cli"
  version "0.1.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.12/pdq-macos-arm64"
      sha256 "b80f88d50e3f7b66273d333776a30389d2b0654aaa95ac583a2ac9f86c5a3efa"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.12/pdq-macos-x64"
      sha256 "78fa3729019e12b7c897d6c9a6706f4f3b02f9e16bda8d28736533f14fb18fde"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.12/pdq-linux-arm64"
      sha256 "f0dce857fbf4cddcd6ddc9009a45917044875f0e3ca02b449f90c14df202c3f2"
    end
    on_intel do
      url "https://github.com/bogdan-calapod/pdq-cli/releases/download/v0.1.12/pdq-linux-x64"
      sha256 "8425ea27ac90ef383d1086bb982ca447e315079f61cf9f711e1b6ed25b5d5f73"
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
