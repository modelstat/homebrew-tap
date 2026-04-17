# modelstat/homebrew-tap

Homebrew tap for the [modelstat](https://modelstat.ai) agent.

## Install

```bash
brew tap modelstat/tap
brew install modelstat
modelstat connect
```

## Brew + npm on the same machine — shared device identity

Installing via Homebrew and via `npm install -g @modelstat/agent` produces **the same binary** (`@modelstat/agent`) that reads and writes the **same state file** — on macOS that's `~/Library/Preferences/modelstat-agent-dev-nodejs/config.json`. So:

- The `deviceUuid` is generated once (on first `modelstat connect` or `modelstat self-register`) and reused by every install method thereafter.
- The server dedupes on `(user_id, machine_id)` and upserts the device row, so re-pairing from a different install still resolves to the same device.
- Uninstalling via one method and reinstalling via the other does **not** create a new device.

Check at any time:

```bash
modelstat paths           # human-readable
modelstat paths --json    # machine-readable (used by @modelstat/mcp)
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
