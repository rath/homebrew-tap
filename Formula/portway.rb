class Portway < Formula
  desc "Compression-first HTTP forwarder"
  homepage "https://github.com/rath/portway"
  url "https://github.com/rath/portway/releases/download/v0.2.3/portway-aarch64-apple-darwin.tar.gz"
  version "0.2.3"
  sha256 "be0e5a60f575e829b0cdcd02ee60c2268d3f3cb886b5fbf2513e011b6b419a87"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/rath/portway/releases/download/v0.2.3/portway-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c08672741c06bb0a1f58b93de01539e6297e2c9ecbc0c280832f22aea7897232"
    end

    on_intel do
      url "https://github.com/rath/portway/releases/download/v0.2.3/portway-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a9759f539efdc33285fbbc11e947994679ea728f9e6b4908d761729b620a4e3e"
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
