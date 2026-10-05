cask "vimdow" do
  version "1.2.0"
  sha256 "8e7cf9318808e6034b9022e617bc2e3d1e6354353b77a20b738be5bae9f44526"

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
