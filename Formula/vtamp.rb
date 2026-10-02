class Vtamp < Formula
  desc "Terminal music player with a persistent playback server"
  homepage "https://github.com/rath/vtamp"
  url "https://github.com/rath/vtamp/releases/download/v0.2.0/vtamp-aarch64-apple-darwin.tar.gz"
  sha256 "4684c2a7d5b4097db34724fe567e15d9e4b8032335a4d5b80a25c0227b57e923"
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
