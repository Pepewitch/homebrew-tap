cask "wisp-desktop" do
  version "0.4.0-alpha.8"
  sha256 "00118b85d520e551c4fe386eece56912ba4113b8fafdb304bda2a90f1dc85b26"

  url "https://github.com/Pepewitch/wisp/releases/download/v#{version}/wisp-desktop-v#{version}-darwin-arm64.tar.gz"
  name "Wisp Desktop"
  desc "Manage local and remote Wisp daemons from one native workspace"
  homepage "https://github.com/Pepewitch/wisp"

  livecheck do
    skip "Wisp Desktop is currently distributed as a prerelease"
  end

  depends_on arch: :arm64
  depends_on macos: :monterey
  depends_on formula: "pepewitch/tap/wisp"

  app "Wisp.app"

  uninstall quit: "dev.wisp.desktop"

  caveats <<~EOS
    This experimental Apple Silicon alpha requires macOS 12.3 or newer. It is
    ad-hoc signed, not Developer ID signed or notarized. On first launch,
    macOS may require explicit approval in Privacy & Security or Finder's Open
    command. Do not disable Gatekeeper globally.

    The required Wisp daemon Formula is installed as a dependency. Wisp Desktop
    asks for confirmation before initializing its profile or starting its
    Homebrew service.

    Uninstalling the Cask quits and removes the app but preserves desktop
    metadata and remote Keychain credentials. Remove remote connections or use
    Reset Desktop Data before uninstalling if you want those credentials
    removed.
  EOS
end
