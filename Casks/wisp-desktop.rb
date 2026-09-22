# frozen_string_literal: true

cask "wisp-desktop" do
  version "0.5.13"
  sha256 "b63d6957f786f2bfee2e88b0aeb4ea9ef55e2a3c61deba1b3c654868cd32e307"

  url "https://github.com/Pepewitch/wisp/releases/download/v#{version}/wisp-desktop-v#{version}-darwin-arm64.tar.gz"
  name "Wisp Desktop"
  desc "Manage local and remote Wisp daemons from one native workspace"
  homepage "https://github.com/Pepewitch/wisp"

  livecheck do
    url "https://raw.githubusercontent.com/Pepewitch/homebrew-tap/main/updates/wisp-desktop-alpha.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :monterey
  depends_on formula: "pepewitch/tap/wisp"

  app "Wisp.app"

  uninstall quit: "dev.wisp.desktop"

  caveats <<~EOS
    This Apple Silicon app requires macOS 12.3 or newer. Wisp Desktop is
    Developer ID signed and notarized. After the initial Homebrew install, the
    application can install its own cryptographically signed updates.

    The required Wisp daemon Formula is installed as a dependency. Wisp Desktop
    asks for confirmation before initializing its profile or starting its
    Homebrew service.

    Uninstalling the Cask quits and removes the app but preserves desktop
    metadata and remote Keychain credentials. Remove remote connections or use
    Reset desktop data before uninstalling if you want those credentials
    removed.
  EOS
end
