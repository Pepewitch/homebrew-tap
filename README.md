# Pepewitch Homebrew Tap

This tap publishes experimental Homebrew formulas maintained by
[Pepewitch](https://github.com/Pepewitch).

## Wisp

Wisp is a harness-independent coding-agent task manager. Its current macOS
alpha supports Apple Silicon only.

```sh
brew install Pepewitch/tap/wisp
wisp init
brew services start wisp
```

The alpha binary is ad-hoc signed. It is not Developer ID signed or notarized,
so Gatekeeper may require explicit approval. Do not disable Gatekeeper
globally.

- [Source](https://github.com/Pepewitch/wisp)
- [Release notes](https://github.com/Pepewitch/wisp/releases)
- [Apple Silicon installation guide](https://github.com/Pepewitch/wisp/blob/main/docs/INSTALL-MACOS.md)
