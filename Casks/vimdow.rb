cask "vimdow" do
  version "1.1.0"
  sha256 "25b4ef2d1612057686dbd7410033d4eb1334695551fb9a31ee6b601f55a088aa"

  url "https://github.com/rath/Vimdow/releases/download/v#{version}/Vimdow.zip"
  name "Vimdow"
  desc "Keyboard-driven window manager with Vim-style commands"
  homepage "https://vimdow.told.me/"

  depends_on macos: :sonoma

  app "Vimdow.app"

  uninstall quit: "rath.toys.VimdowManager"

  zap trash: "~/Library/Preferences/rath.toys.VimdowManager.plist"

  caveats "Allow Vimdow in System Settings → Privacy & Security → Accessibility."
end
