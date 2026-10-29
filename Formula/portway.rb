class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.4.0/portway-aarch64-apple-darwin.tar.gz"
  version "0.4.0"
  sha256 "47a16f3d0298250c99ae342682a02115d23e3834921d5e5957027c7fb0c2c1fa"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.4.0/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e943a8f3f7cd2aa9c124b85ff4c8063df2efe335209123af4a1dbfb92eb5e7b"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.4.0/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f88e9ae292cc1d5c50ff8a266a9c399f5b72ed948219db2de9fffc4f417d3ad2"
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
