class Modelstat < Formula
  desc "Cross-tool AI spend analytics agent — track every AI coding token"
  homepage "https://modelstat.ai"
  url "https://registry.npmjs.org/@modelstat/agent/-/agent-0.0.7.tgz"
  sha256 "aac51d11bf4cb3e6b2691736f57caaf08512b67da1d40b6206c163d5541d00a4"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # `modelstat --version` exits 1 today (the CLI doesn't recognise
    # the flag) and falls through to the help text. Grep for the binary
    # responding at all — that's enough for a Homebrew sanity check.
    assert_match "modelstat", shell_output("#{bin}/modelstat nonsense-subcommand 2>&1", 1)
  end

  def caveats
    <<~EOS
      modelstat is installed. Pair this device to start tracking:
          modelstat connect

      macOS: a launchd user agent keeps the daemon running in the
      background and starts it at login. Dashboard: https://modelstat.ai/dashboard
    EOS
  end
end
