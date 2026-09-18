cask "prompt-line" do
  version "0.40.2"
  sha256 "48dc28f86c8ab4adb109aba6b260c0e421219dbae837b7dab7326ff3b8861266"

  url "https://github.com/nkmr-jp/prompt-line/releases/download/prompt-line-v#{version}/Prompt-Line-#{version}-arm64.dmg"
  name "Prompt Line"
  desc "Quick input window for AI coding agents (Claude Code, Codex CLI, Aider)"
  homepage "https://github.com/nkmr-jp/prompt-line"

  livecheck do
    url :url
    regex(/^prompt-line-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on formula: "fd"
  depends_on formula: "ripgrep"
  depends_on macos: :ventura

  app "Prompt Line.app"
  binary "#{appdir}/Prompt Line.app/Contents/Resources/prompt-line.sh",
         target: "prompt-line"

  # The app is signed with a fixed self-signed certificate ("Prompt Line"),
  # not an Apple Developer ID certificate. Homebrew stamps every download
  # with com.apple.quarantine, which would block first launch for an
  # unnotarized app, so we remove it here. --no-quarantine was removed
  # from Homebrew, making this the only automated path.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Prompt Line.app"],
        writable_paths: ["{{appdir}}/Prompt Line.app"],
        must_succeed:   false
  end

  uninstall quit: "com.electron.prompt-line"

  zap trash: "~/.prompt-line"

  caveats <<~EOS
    prompt-line is unsigned (self-signed certificate "Prompt Line") and not
    notarized. The cask removes the quarantine attribute automatically; if a
    future Homebrew blocks that, run this manually once:

      xattr -dr com.apple.quarantine "/Applications/Prompt Line.app"

    Prompt Line requires Accessibility permission to paste text:
      System Settings > Privacy & Security > Accessibility

    fd and ripgrep (used by file/symbol search) are installed automatically
    as formula dependencies.
  EOS
end
