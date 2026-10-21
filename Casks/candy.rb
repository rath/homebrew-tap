cask "candy" do
  version "0.3.1"
  sha256 "5afbfb0f8301c9eaa3a55cbd02593c8c8c198465badbc41c4e3b9726d6b17696"

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
