class Iotap < Formula
  desc "Trace the file and network I/O of processes"
  homepage "https://iotap.told.me"
  url "https://github.com/rath/iotap/releases/download/v0.2.2/iotap-aarch64-apple-darwin.tar.gz"
  sha256 "1dfcb0f3e251cdeff7c1b5cd2f18f1f6e0ddc107a05069988d1e181ccd2f1757"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "elfutils"
    depends_on "zlib-ng-compat"

    on_arm do
      url "https://github.com/rath/iotap/releases/download/v0.2.2/iotap-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4fab70b85b0d00b036b6cb701ff553477db37309444d0d12ad015b72e75d68a"
    end

    on_intel do
      url "https://github.com/rath/iotap/releases/download/v0.2.2/iotap-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aa23e90ff6d29042fab834d5e10aaaeeb9ae7cb5e57ae48091097b01eddd46ea"
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
