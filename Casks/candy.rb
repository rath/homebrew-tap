cask "candy" do
  version "0.2.4"
  sha256 "55d00017b02af0103a7f22a80bcb874043dd24356923f460a2a7490ddc3ccdc7"

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
