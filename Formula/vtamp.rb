class Vtamp < Formula
  desc "Terminal music player with a persistent playback server"
  homepage "https://github.com/rath/vtamp"
  url "https://github.com/rath/vtamp/releases/download/v0.1.0/vtamp-aarch64-apple-darwin.tar.gz"
  sha256 "a01e47e1732b81d8c165575aa97261c2da70f809c428baa22f971595e3362e7f"
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
