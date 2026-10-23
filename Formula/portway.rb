class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.3.0/portway-aarch64-apple-darwin.tar.gz"
  version "0.3.0"
  sha256 "a2a5f39b4f4c1cba2512ec91e97aa49ea2dabc783c41575a76da3435172dd0cd"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.3.0/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cead0011ac7c5c350f83b719a6b8a2cc150f4f304239e3a63725541b3aaf66a6"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.3.0/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "654292e2b7c58091ab191f1120dcc82d9a686dffb5ca3ae53d2d9ec45074621c"
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
