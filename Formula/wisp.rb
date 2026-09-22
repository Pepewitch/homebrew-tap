# typed: strict
# frozen_string_literal: true

# Wisp installs the native Apple Silicon CLI and its launchd service.
class Wisp < Formula
  desc "Harness-independent coding-agent task manager"
  homepage "https://github.com/Pepewitch/wisp"
  url "https://github.com/Pepewitch/wisp/releases/download/v0.5.14/wisp-v0.5.14-darwin-arm64.tar.gz"
  sha256 "b446134b411da1773fc347d88a935919a98e623ee0eecc3b07b2c1218643a8c2"
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
