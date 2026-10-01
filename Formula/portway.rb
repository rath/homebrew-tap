class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.2.2/portway-aarch64-apple-darwin.tar.gz"
  version "0.2.2"
  sha256 "caac615f80641d2ea47be17a35a2ea5bd327eb66b5ee6965705df18d15983ee9"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.2.2/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0ab2e23337ddb4af1145fa53b13064426796e18d31e81e236ae55ee50329e9fd"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.2.2/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e990f42cb75ae5e153cc375dcfa4953ed9a3a5872d24b36a2669931852d6b7f2"
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
  end
end
