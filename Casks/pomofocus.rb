cask "pomofocus" do
  version "0.22.10"
  sha256 "6abe01ed9b313f89ce5b8c46ef4d1275a34278ac8b888c07bea5e5081dc9291a"

  url "https://github.com/CryptoChefA/pomofocus-mac/releases/download/v#{version}/Pomofocus.zip"
  name "Pomofocus for Mac"
  desc "Free, private Pomodoro and study timer"
  homepage "https://cryptochefa.github.io/pomofocus-mac/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Pomofocus.app"

  # Pomofocus isn't notarized by Apple yet. Installing through Homebrew is the choice to
  # trust it, so the download quarantine is cleared and it opens without Open Anyway.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Pomofocus.app"],
        writable_paths: ["{{appdir}}/Pomofocus.app"]
  end

  zap trash: [
    "~/Library/Application Support/Pomofocus",
    "~/Library/Containers/org.pomodorononna.app.widget",
    "~/Library/Preferences/org.pomodorononna.app.plist",
  ]
end
