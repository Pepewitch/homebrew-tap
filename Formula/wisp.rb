# typed: strict
# frozen_string_literal: true

# Wisp installs the native Apple Silicon CLI and its launchd service.
class Wisp < Formula
  desc "Harness-independent coding-agent task manager"
  homepage "https://github.com/Pepewitch/wisp"
  url "https://github.com/Pepewitch/wisp/releases/download/v0.4.0-alpha.16/wisp-v0.4.0-alpha.16-darwin-arm64.tar.gz"
  sha256 "55531639a6da0a0b0d7c3113d5560a463f92750921c21a9bddf8f2fbc2c3c1c3"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "wisp"
  end

  def caveats
    <<~EOS
      This experimental Apple Silicon alpha is ad-hoc signed, not Developer ID
      signed or notarized. Gatekeeper may require explicit approval. Do not
      disable Gatekeeper globally.

      Initialize and start Wisp:
        wisp init
        brew services start wisp
    EOS
  end

  service do
    run [opt_bin/"wisp", "serve"]
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
