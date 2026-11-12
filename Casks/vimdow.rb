cask "vimdow" do
  version "1.3.2"
  sha256 "9499e94a1560f5adc24c37c06b6938c51b7da508c0ba83ebff9fca38a989157f"

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
