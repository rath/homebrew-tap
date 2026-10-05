class Vtamp < Formula
  desc "Terminal music player with a persistent playback server"
  homepage "https://github.com/rath/vtamp"
  url "https://github.com/rath/vtamp/releases/download/v0.5.0/vtamp-aarch64-apple-darwin.tar.gz"
  sha256 "21e7d104fa366a748592326e2e36370f3795aa672f107110d33ad3f506ee0dd1"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "vtamp"
    pkgshare.install "themes", "examples"
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
    manifest = pkgshare/"examples/hello-panel/plugin.json"
    assert_match "hello-panel", shell_output("#{bin}/vtamp plugin add #{manifest} --json")
    assert_match "hello-panel", shell_output("#{bin}/vtamp plugin list --json")
    assert_match "hello-panel", shell_output("#{bin}/vtamp plugin remove hello-panel --json")
    assert_path_exists pkgshare/"examples/pastel-transcript/pastel-transcript"
    refute_path_exists testpath/"home/state.db"
  end
end
