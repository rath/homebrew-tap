class Vtamp < Formula
  desc "Terminal music player with a persistent playback server"
  homepage "https://github.com/rath/vtamp"
  url "https://github.com/rath/vtamp/releases/download/v0.3.0/vtamp-aarch64-apple-darwin.tar.gz"
  sha256 "c575e194c521f5d42cffae7ed269ec0f601af4e6a671118a34b98bece359ae38"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "vtamp"
  end

  test do
    assert_equal "vtamp #{version}", shell_output("#{bin}/vtamp --version").strip
    help = shell_output("#{bin}/vtamp --help")
    assert_match "attach", help
    assert_match "doctor", help
    assert_match "--json", help
  end
end
