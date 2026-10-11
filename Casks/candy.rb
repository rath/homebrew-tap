cask "candy" do
  version "0.1.1"
  sha256 "2482653ecc490c36263d98e48c86ab34e827c8d934fbd9bb6ee5aef98cd49ff0"

  url "https://github.com/rath/candy/releases/download/v#{version}/Candy-#{version}-macos-arm64.zip"
  name "Candy"
  desc "Native image editor and terminal image utility"
  homepage "https://candy.told.me/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Candy.app"
  binary "#{appdir}/Candy.app/Contents/Helpers/candy"

  uninstall quit: "org.candyapp.Candy"

  zap trash: "~/Library/Preferences/org.candyapp.Candy.plist"
end
