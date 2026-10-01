# homebrew-tap

Homebrew formulae by Jang-Ho Hwang

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
