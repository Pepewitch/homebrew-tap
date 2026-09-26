# typed: strict
# frozen_string_literal: true

# Wisp installs the native Apple Silicon CLI and its launchd service.
class Wisp < Formula
  desc "Harness-independent coding-agent task manager"
  homepage "https://github.com/Pepewitch/wisp"
  url "https://github.com/Pepewitch/wisp/releases/download/v0.6.3/wisp-v0.6.3-darwin-arm64.tar.gz"
  sha256 "c87fd4314e80cb068bd40c9e3a924c568e86e70edd58a6a8d981f203996dfda6"
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
