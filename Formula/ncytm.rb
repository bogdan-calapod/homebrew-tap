class Ncytm < Formula
  desc "YouTube Music client for the terminal"
  homepage "https://github.com/bogdan-calapod/ncytm"
  url "https://github.com/bogdan-calapod/ncytm/archive/refs/tags/v1.0.13.tar.gz"
  sha256 "41d84ada8b517aab13b4e491d4c6374d92c0cfd49ce241c38f52fbb3a01a941e"
  license "BSD-2-Clause"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncytm --version")
  end
end
