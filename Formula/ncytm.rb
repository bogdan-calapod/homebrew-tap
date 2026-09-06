class Ncytm < Formula
  desc "YouTube Music client for the terminal"
  homepage "https://github.com/bogdan-calapod/ncytm"
  url "https://github.com/bogdan-calapod/ncytm/archive/refs/tags/v1.0.19.tar.gz"
  sha256 "ad9b0d85600234a1068c80562d0d56451836ad279c6528bd16ca9be13c0ac5b6"
  license "BSD-2-Clause"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncytm --version")
  end
end
