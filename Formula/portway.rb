class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.2.7/portway-aarch64-apple-darwin.tar.gz"
  version "0.2.7"
  sha256 "4dd07d84bd7d94877f8e86cae10c719e7af2097b2086294eff45de8bc0db8835"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.2.7/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d463c2c351f9b569d75f40f495fb5e5a4e266023ca9d54a5978fbd42f3bd7a87"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.2.7/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "21c6f8c820b7eeec66a2b5341051bd0873f4f3bc233cc91fe095444aeb0844cf"
    end
  end

  def install
    bin.install "portway"
  end

  test do
    assert_equal "portway #{version}", shell_output("#{bin}/portway --version").strip
    help = shell_output("#{bin}/portway --help")
    assert_match "--web", help
    assert_match "--tui", help
    assert_match "--attach", help
    assert_match "--apply", shell_output("#{bin}/portway setup --help")
    assert_match "--url", shell_output("#{bin}/portway doctor --help")

    ENV["CODEX_HOME"] = (testpath/"codex").to_s
    ENV["CLAUDE_CONFIG_DIR"] = (testpath/"claude").to_s
    shell_output("#{bin}/portway setup --client both --url http://127.0.0.1:8787 --apply")
    assert_match 'model_provider = "portway"', (testpath/"codex/portway.config.toml").read
    assert_match "http://127.0.0.1:8787/anthropic", (testpath/"claude/settings.json").read
  end
end
