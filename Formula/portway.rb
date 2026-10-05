class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.2.4/portway-aarch64-apple-darwin.tar.gz"
  version "0.2.4"
  sha256 "60e8642d56a593747af212027283c8dcf40c68302dd33e94adb5e7812fb43bff"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.2.4/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "366642931843fd160f626cfd9fa177309412359e717e0ea92b44a65c2794a4ba"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.2.4/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "63aae93a3547cdf4bc9c7e23759f032ea705e092ca9311eb3ec36f0ad5e77e12"
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
