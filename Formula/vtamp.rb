class Vtamp < Formula
  desc "Terminal music player with a persistent playback server"
  homepage "https://github.com/rath/vtamp"
  url "https://github.com/rath/vtamp/releases/download/v0.4.3/vtamp-aarch64-apple-darwin.tar.gz"
  sha256 "b1e4a567f3a355701d567e95f1d7d3ec8a81f1ddd547d0c1415af2d5a3354b72"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "vtamp"
    pkgshare.install "themes"
    doc.install "README.md", "CHANGELOG.md", "docs"
  end

  test do
    assert_equal "vtamp #{version}", shell_output("#{bin}/vtamp --version").strip
    help = shell_output("#{bin}/vtamp --help")
    assert_match "attach", help
    assert_match "doctor", help
    assert_match "--json", help
    ENV["VTAMP_HOME"] = (testpath/"home").to_s
    theme = pkgshare/"themes/pastel/pastel-default.json"
    assert_match "pastel-default", shell_output("#{bin}/vtamp theme install #{theme} --json")
    assert_match "pastel-default", shell_output("#{bin}/vtamp theme list --json")
    refute_path_exists testpath/"home/state.db"
  end
end
