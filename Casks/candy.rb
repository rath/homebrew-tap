cask "candy" do
  version "0.2.3"
  sha256 "118083753c569aba0d224143fd140f8f8a77f457d58c7f3f226e0851cc6210bf"

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
