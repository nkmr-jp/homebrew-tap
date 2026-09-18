# homebrew-tap

Personal Homebrew tap for [nkmr-jp](https://github.com/nkmr-jp) projects.

## Casks

### prompt-line

[Prompt Line](https://github.com/nkmr-jp/prompt-line) — a quick input window
for AI coding agents such as Claude Code, Codex CLI, and Aider.

```bash
brew install --cask nkmr-jp/tap/prompt-line
```

Upgrade:

```bash
brew upgrade --cask prompt-line
```

Uninstall (keeps your data in `~/.prompt-line`):

```bash
brew uninstall --cask prompt-line
```

To remove data as well:

```bash
brew uninstall --cask --zap prompt-line
```

The install also links the bundled `prompt-line` CLI (no Node.js
required — it runs on the app's embedded Electron runtime):

```bash
prompt-line plugin install github.com/nkmr-jp/prompt-line-plugins
prompt-line reset-accessibility
prompt-line migrate-settings
```

#### Signing

Prompt Line is signed with a fixed self-signed certificate ("Prompt Line"),
not an Apple Developer ID certificate, and is not notarized. Homebrew stamps
every download with `com.apple.quarantine`, so the cask removes that attribute
in a `postflight` step after installing to `/Applications`. Because the
certificate is the same across releases, Accessibility permission granted once
survives `brew upgrade` reinstalls.

The cask uses `postflight_steps`, which requires a recent Homebrew — run
`brew update` first if your installation is old. If a future Homebrew
blocks the removal, run this once manually:

```bash
xattr -dr com.apple.quarantine "/Applications/Prompt Line.app"
```

#### Migrating from a manual install

If you already installed Prompt Line from source (`pnpm run install-app`),
`/Applications/Prompt Line.app` exists and `brew install --cask` will refuse
to overwrite it. Either remove the existing app first, or let brew adopt it:

```bash
brew install --cask --adopt nkmr-jp/tap/prompt-line
```

Your data in `~/.prompt-line` is untouched either way.

Note that source builds sign the app with a per-machine certificate while
the cask ships a binary signed with the release certificate, so the TCC
designated requirement changes on switch — re-grant Accessibility
permission once after migrating.

#### Accessibility permission

Prompt Line needs Accessibility permission to paste text into other
applications. Grant it on first launch:
**System Settings > Privacy & Security > Accessibility**.

#### Dependencies

`fd` and `ripgrep` (used by file search and symbol search features) are
declared as formula dependencies in the cask, so `brew install --cask`
brings them in automatically — no separate step needed.

#### Tap trust

The cask runs a `postflight` step (to remove the quarantine attribute),
so Homebrew refuses to load it from an untrusted tap. If you see
`Refusing to load cask ... from untrusted tap`, trust the tap once:

```bash
brew trust nkmr-jp/tap
```
