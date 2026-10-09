class Iotap < Formula
  desc "Trace the file and network I/O of processes"
  homepage "https://iotap.told.me"
  url "https://github.com/rath/iotap/releases/download/v0.2.1/iotap-aarch64-apple-darwin.tar.gz"
  sha256 "09199c653afcc93212bd908a12e78a0e67839d1bf193e3c33d4ba5f5674e3be0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "elfutils"
    depends_on "zlib-ng-compat"

    on_arm do
      url "https://github.com/rath/iotap/releases/download/v0.2.1/iotap-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "868d38ee81845007285b01a4eafc981e62ec3cee70e97fd662db48efc44b95fa"
    end

    on_intel do
      url "https://github.com/rath/iotap/releases/download/v0.2.1/iotap-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "38c4bc8c3364869c621dfef26db5a0c0d2f7027938216b1bd27bec58fae3ca59"
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
