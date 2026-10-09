cask "vimdow" do
  version "1.3.0"
  sha256 "7dcd794a32e26d3a0369d042fb323e7e9ec605167239e1a73a8a3c79cd739663"

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
