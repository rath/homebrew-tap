# homebrew-tap

Homebrew formulae by Jang-Ho Hwang

## iotap

[iotap](https://iotap.told.me) traces the file and network I/O of chosen
processes: each read and write with its path or socket endpoint, size, and latency.
This formula installs prebuilt release binaries; Rust is not required.

### Install

```sh
brew install rath/tap/iotap
```

Supported platforms:

| Operating system | Architecture |
| --- | --- |
| macOS | Apple Silicon (ARM64) |
| Linux | x86_64 or ARM64 |

Intel Macs can build from source. Linux release binaries target glibc 2.28 or
newer; Homebrew and its dependencies have their own OS requirements. The formula
installs the required libelf and zlib libraries through Homebrew.

Tracing needs root, and Linux needs kernel 5.8 or newer with BPF and syscall
tracepoints. Replace `1234` with the PID of a running process:

```sh
sudo iotap --tui 1234
```

On macOS, stop other kdebug tracers such as `fs_usage` before tracing. Replaying
a saved recording with `iotap --replay FILE` does not require root.

### Update

```sh
brew update
brew upgrade iotap
```

### Verify

```sh
brew test rath/tap/iotap
"$(brew --prefix iotap)/bin/iotap" --version
```

These checks do not need root. The explicit path selects the Homebrew binary
even if another copy of `iotap` appears earlier on your `PATH`.

## Portway

[Portway](https://github.com/rath/portway) is a compression-first HTTP forwarder
with a terminal dashboard and a web console. This formula installs prebuilt
release binaries, including both dashboards; Rust is not required.

### Install

```sh
brew install rath/tap/portway
```

Supported platforms:

| Operating system | Architecture |
| --- | --- |
| macOS | Apple Silicon (ARM64) |
| Linux | x86_64 or ARM64, with glibc 2.28 or newer |

Intel Macs are not currently supported.

### Update

```sh
brew update
brew upgrade portway
```

Restart any running Portway process to use the new binary.

### Verify

```sh
brew test rath/tap/portway
"$(brew --prefix portway)/bin/portway" --version
```

The explicit path selects the Homebrew installation even if another copy of
`portway` appears earlier on your `PATH`.

## vtamp

[vtamp](https://github.com/rath/vtamp) is a detachable terminal music player: a
persistent playback server with terminal clients, so music keeps playing when
the interface exits or a tmux client detaches. This formula installs a prebuilt,
self-contained release binary; Rust is not required.

### Install

```sh
brew install rath/tap/vtamp
```

Supported platforms:

| Operating system | Architecture |
| --- | --- |
| macOS | Apple Silicon (ARM64) |

Intel Macs and Linux are not supported by this formula; build from source instead.

### Update

```sh
brew update
brew upgrade vtamp
```

Run `vtamp server stop` afterwards so the next `vtamp` starts the new build; a
running playback server is never replaced by an install.

### Verify

```sh
brew test rath/tap/vtamp
"$(brew --prefix vtamp)/bin/vtamp" --version
```

The explicit path selects the Homebrew installation even if another copy of
`vtamp` appears earlier on your `PATH`.

## Vimdow

[Vimdow](https://vimdow.told.me) is a keyboard-driven window manager for macOS.
Enter command mode to move, resize, snap, and switch windows with Vim-style keys.
Mark individual windows, then use Control–Option–[ and Control–Option–] to cycle
backward and forward, wrapping at both ends. Both shortcuts are customizable
in Settings. Optional tmux pane numbers can be enabled in Settings → General.

### Install

```sh
brew install rath/tap/vimdow
```

Requires macOS 14 (Sonoma) or later on Apple Silicon or Intel. The cask installs
a universal app signed with Developer ID and notarized by Apple.

Open **Vimdow.app** from Applications and allow it in **System Settings →
Privacy & Security → Accessibility**. Press **Control–Option–A** to enter
command mode and `,` to open Settings.

### Update

Quit Vimdow first: press **Control–Option–A**, then `x`.

```sh
brew update
brew upgrade --cask vimdow
open /Applications/Vimdow.app
```

Window marks last only while Vimdow is running, so mark them again after restarting.
