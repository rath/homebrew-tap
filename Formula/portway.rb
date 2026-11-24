class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.4.3/portway-aarch64-apple-darwin.tar.gz"
  version "0.4.3"
  sha256 "4b02889f2669a9ae262dc4a06d326b76fd376bfaac40ddb28e54ddfcb419e672"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.4.3/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b769ad4c71373f1e6ee0addd2563b3160ec0c7c80671002dc56ddc640c36669b"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.4.3/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10a1496c5fcb7fc47ccf652373f41143cd0822491652248093f8745075991aa5"
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
