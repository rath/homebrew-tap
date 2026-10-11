cask "vimdow" do
  version "1.3.1"
  sha256 "f710c9e33cb63f72c4e4e3d14130e8d8938c802e8412f6ab7ea8c03a210418aa"

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
