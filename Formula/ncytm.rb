class Ncytm < Formula
  desc "YouTube Music client for the terminal"
  homepage "https://github.com/bogdan-calapod/ncytm"
  url "https://github.com/bogdan-calapod/ncytm/archive/refs/tags/v1.0.16.tar.gz"
  sha256 "82d5173374e80bb70ee5056477d00f80bd315e42f775297e9620df1a4abad3ea"
  license "BSD-2-Clause"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncytm --version")
  end
end
