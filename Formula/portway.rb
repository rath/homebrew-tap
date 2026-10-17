class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.2.6/portway-aarch64-apple-darwin.tar.gz"
  version "0.2.6"
  sha256 "e1d19e4c935be54df601757296054b5fac4aa9d23e1a3dabec6395924aa20bb2"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.2.6/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cc1f5325659ac782d49587f50f14334231def66e71f7fae0b6bfcdc2ba8e7ef6"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.2.6/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a3969bc3d9ef77ad056a03a38261ef2057bffedddfc63206ce914b39b338179"
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
