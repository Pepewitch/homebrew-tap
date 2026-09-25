# typed: strict
# frozen_string_literal: true

# Wisp installs the native Apple Silicon CLI and its launchd service.
class Wisp < Formula
  desc "Harness-independent coding-agent task manager"
  homepage "https://github.com/Pepewitch/wisp"
  url "https://github.com/Pepewitch/wisp/releases/download/v0.6.2/wisp-v0.6.2-darwin-arm64.tar.gz"
  sha256 "0d136e3ad4fe31c7d5c3cc3ad87ecdabd2974579b35d8e245e2ee9a413a8aa9f"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install "Wisp Daemon.app"
    bin.install_symlink libexec/"Wisp Daemon.app/Contents/MacOS/wisp"
  end

  def caveats
    <<~EOS
      This Apple Silicon daemon is Developer ID signed and
      notarized. Its branded background app and stable code identity preserve
      the App Management icon and privacy permission across upgrades.

      Initialize and start Wisp:
        wisp init
        brew services start wisp
    EOS
  end

  service do
    run [opt_libexec/"Wisp Daemon.app/Contents/MacOS/wisp", "serve"]
    keep_alive true
    working_dir Dir.home
    environment_variables PATH: "#{std_service_path_env}:#{Dir.home}/.local/bin:#{Dir.home}/.bun/bin"
    log_path var/"log/wisp.log"
    error_log_path var/"log/wisp.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wisp version")
  end
end
