class Osdd < Formula
  desc "OpenSDD CLI tool"
  homepage "https://github.com/opensdd/osdd-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-arm64.tar.gz"
      sha256 "84d12ed5bb9ea9982373cae0b462f0259bee1e7434be18aec651ce020ff25e52"
    end

    on_intel do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-amd64.tar.gz"
      sha256 "5fb5a0cc7d5bc63775d5125f62a605d59f5df9bcd058d39c3ec59e65894d3254"
    end
  end

  def install
    bin.install Dir["osdd-*"].first => "osdd"
  end

  test do
    system "#{bin}/osdd", "version"
  end
end
