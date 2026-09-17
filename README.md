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

#### Signing

Prompt Line is signed with a fixed self-signed certificate ("Prompt Line"),
not an Apple Developer ID certificate, and is not notarized. Homebrew stamps
every download with `com.apple.quarantine`, so the cask removes that attribute
in a `postflight` step after installing to `/Applications`. Because the
certificate is the same across releases, Accessibility permission granted once
survives `brew upgrade` reinstalls.

If a future Homebrew blocks the removal, run this once manually:

```bash
xattr -dr com.apple.quarantine "/Applications/Prompt Line.app"
```

#### Accessibility permission

Prompt Line needs Accessibility permission to paste text into other
applications. Grant it on first launch:
**System Settings > Privacy & Security > Accessibility**.

#### Optional dependencies

File search and symbol search features use `fd` and `ripgrep`:

```bash
brew install fd ripgrep
```

#### nix-darwin / home-manager

```nix
homebrew.taps = [
  { name = "nkmr-jp/tap"; trusted = true; }
];
homebrew.casks = [ "prompt-line" ];
```

`trusted = true` is required because the cask runs a `postflight` step.
