class Vtamp < Formula
  desc "Terminal music player with a persistent playback server"
  homepage "https://github.com/rath/vtamp"
  url "https://github.com/rath/vtamp/releases/download/v0.4.2/vtamp-aarch64-apple-darwin.tar.gz"
  sha256 "76bac078ddca916348be63b517144a8d11d0f16146026c2fbb456fd0c5d24a6f"
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
