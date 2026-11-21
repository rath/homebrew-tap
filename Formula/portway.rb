class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.4.2/portway-aarch64-apple-darwin.tar.gz"
  version "0.4.2"
  sha256 "9df49e9a394c4a9b56c292f1593f210ee6e38158dc30ede73305ea00c9d81728"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.4.2/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "015c74fac117af1b75fde7be7b87ea5d7bee39296f248ad71594dc4a6ca5f011"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.4.2/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c1bd3b1a9cf8089c8e0ef2a73abb82c9e6bc4233dbb101a0a02e40f89341fde5"
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
