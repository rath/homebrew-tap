class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.4.1/portway-aarch64-apple-darwin.tar.gz"
  version "0.4.1"
  sha256 "1b2244e4e815f5f86cbf6a78494e556d15c7a81053502c636a7acb4cb8b8d805"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.4.1/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e7367c993bb525a9b9603121bd104a9911063c6e1bb4d99cce4843548f1f559"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.4.1/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55b463d6d48f4d23c60959d155a4f8c18edb62112a7adfa3452267573a113db4"
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
