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
