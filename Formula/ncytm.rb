class Ncytm < Formula
  desc "YouTube Music client for the terminal"
  homepage "https://github.com/bogdan-calapod/ncytm"
  url "https://github.com/bogdan-calapod/ncytm/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "478d200141fe4f12751af97776c85ca4a5e74a9186966c171be5ad646b00f1e0"
  license "BSD-2-Clause"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncytm --version")
  end
end
