class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.2.5/portway-aarch64-apple-darwin.tar.gz"
  version "0.2.5"
  sha256 "b08baf0b714c9b0cf9312aca10dab15cc31dc9dbf78d4738844f1761be6c0172"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.2.5/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25d8dc087e5d18498fce351f664201691309202c1e800085e47becaa69c0d488"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.2.5/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "784c896fc3378d2970b87ba7e60d5dd10d770831e5a007e66ac0e59db985429d"
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
