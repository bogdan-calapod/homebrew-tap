class Ncytm < Formula
  desc "YouTube Music client for the terminal"
  homepage "https://github.com/bogdan-calapod/ncytm"
  url "https://github.com/bogdan-calapod/ncytm/archive/refs/tags/v1.0.14.tar.gz"
  sha256 "11339bf2415e1dff1e999d41c0a58e608a34fa68ed728cf6580e6a51a0fc465f"
  license "BSD-2-Clause"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncytm --version")
  end
end
