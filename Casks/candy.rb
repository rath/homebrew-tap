cask "candy" do
  version "0.1.0"
  sha256 "1be325c85779f3e685d30accd6c4ca0e63155b7a57056867e764435c7446e283"

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
