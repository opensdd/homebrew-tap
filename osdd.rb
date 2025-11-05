class Osdd < Formula
  desc "OpenSDD CLI tool"
  homepage "https://github.com/opensdd/osdd-cli"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-arm64.tar.gz"
      sha256 "ee13774b88fa9abb3823530929ea5af2b4ac782910db8df51bc2c35f7a7c7f3a"
    end

    on_intel do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-amd64.tar.gz"
      sha256 "eabb011717411f969d23e92bb690a774df3ee93cdcd9a23952b5cfebbee8f0c6"
    end
  end

  def install
    bin.install Dir["osdd-*"].first => "osdd"
  end

  test do
    system "#{bin}/osdd", "version"
  end
end
