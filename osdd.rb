class Osdd < Formula
  desc "OpenSDD CLI tool"
  homepage "https://github.com/opensdd/osdd-cli"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-arm64.tar.gz"
      sha256 "eab5a34ca837e99508dac1675a71fdc6904350d5323b18ac6e28fc8dfac3012b"
    end

    on_intel do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-amd64.tar.gz"
      sha256 "904c152c0686efa817e0ec7eedcb124ce8ed8105a3def4a975952a37161d7cd7"
    end
  end

  def install
    bin.install Dir["osdd-*"].first => "osdd"
  end

  test do
    system "#{bin}/osdd", "version"
  end
end
