class Osdd < Formula
  desc "OpenSDD CLI tool"
  homepage "https://github.com/opensdd/osdd-cli"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-arm64.tar.gz"
      sha256 "90c7a50649a1f439448344ecbe6166b2cc4e11543f799d5d8ea14a8aabc75d97"
    end

    on_intel do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-amd64.tar.gz"
      sha256 "28a68dbd3ad3072b8d044a00e8d40ccf423997aa716861f4d36d7f1d796c8c0d"
    end
  end

  def install
    bin.install Dir["osdd-*"].first => "osdd"
  end

  test do
    system "#{bin}/osdd", "version"
  end
end
