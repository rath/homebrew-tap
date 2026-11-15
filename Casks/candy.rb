cask "candy" do
  version "0.3.4"
  sha256 "891472fac9d72d0c3bf516bc3312aa5dcc0e31f506b258dc55a9a8c317acad4f"

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
