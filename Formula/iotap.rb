class Iotap < Formula
  desc "Trace the file and network I/O of processes"
  homepage "https://iotap.told.me"
  url "https://github.com/rath/iotap/releases/download/v0.2.0/iotap-aarch64-apple-darwin.tar.gz"
  sha256 "10e01d3d07bb338a04826e686ca5bfbd3d740c5699a2ff6f81d6a05fd23effcb"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "elfutils"
    depends_on "zlib-ng-compat"

    on_arm do
      url "https://github.com/rath/iotap/releases/download/v0.2.0/iotap-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "48849b61b2ecbd22d5bb7bb45d928af86e1e71a516c278a8e759ebf5048a6e63"
    end

    on_intel do
      url "https://github.com/rath/iotap/releases/download/v0.2.0/iotap-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e433b46a20b12f54c653f07b4784c860eb5b2f85b03aff5036a98c1361d11b2b"
    end
  end

  def install
    bin.install "iotap"
    return unless OS.linux?

    # Prebuilt binaries need the same library search paths as a Homebrew build.
    # Homebrew's relocation step selects its loader when the host needs it.
    rpaths = [formula_opt_lib("elfutils"), formula_opt_lib("zlib-ng-compat"), HOMEBREW_PREFIX/"lib"]
    system "patchelf", "--set-rpath", rpaths.join(":"), bin/"iotap"
  end

  def caveats
    <<~EOS
      Tracing needs root: sudo iotap --tui <PID>
      Replaying a recording does not: iotap --replay <FILE>
      Linux tracing needs kernel 5.8 or newer with BPF and syscall tracepoints.
    EOS
  end

  test do
    assert_equal "iotap #{version}", shell_output("#{bin}/iotap --version").strip
    help = shell_output("#{bin}/iotap --help")
    assert_match "--tui", help
    assert_match "--children", help
    assert_match "--replay", help
    (testpath/"invalid.iotaprec").write "not an iotap recording"
    assert_match "not an iotap recording",
                 shell_output("#{bin}/iotap --replay #{testpath}/invalid.iotaprec 2>&1", 1)
  end
end
