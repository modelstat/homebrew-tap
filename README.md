# modelstat/homebrew-tap

Homebrew tap for the [modelstat](https://modelstat.ai) agent.

## Install

```bash
brew tap modelstat/tap
brew install modelstat
modelstat connect
```

## What this installs

The `modelstat` CLI (npm package `@modelstat/agent`). After `modelstat connect`:

- **macOS:** a launchd user agent at `~/Library/LaunchAgents/ai.modelstat.agent.plist` keeps the daemon running and starts it at login.
- **Linux (if you install via Homebrew on Linux):** a systemd user unit at `~/.config/systemd/user/modelstat.service`.

## How this tap is maintained

Source of truth: the `Formula/modelstat.rb` file in this repo. On every new release of `@modelstat/agent`:

1. Fetch the tarball from the npm registry: `https://registry.npmjs.org/@modelstat/agent/-/agent-<version>.tgz`
2. Recompute the SHA-256: `shasum -a 256 <path-to-tarball>`
3. Update `url` and `sha256` in `Formula/modelstat.rb`
4. Commit + push

The release workflow in the main modelstat repo opens a PR here automatically after each npm publish.
