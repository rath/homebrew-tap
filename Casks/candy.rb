cask "candy" do
  version "0.3.0"
  sha256 "62e80603739564f3f25e7ed91d0cc7c99fb1fddd84083defc4e831d4d89097bb"

  url "https://github.com/rath/candy/releases/download/v#{version}/Candy-#{version}-macos-arm64.zip"
  name "Candy"
  desc "Native image editor and terminal image utility"
  homepage "https://candy.told.me/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Candy.app"
  binary "#{appdir}/Candy.app/Contents/Helpers/candy"

  uninstall quit: "me.told.candy.app"

  zap trash: "~/Library/Preferences/me.told.candy.app.plist"
end
