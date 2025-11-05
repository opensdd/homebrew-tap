class Osdd < Formula
  desc "OpenSDD CLI tool"
  homepage "https://github.com/opensdd/osdd-cli"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-arm64.tar.gz"
      sha256 "6dc5aa82e94159be78019debab63f1705b49714032b2db8c0a1bc0ec33513680"
    end

    on_intel do
      url "https://github.com/opensdd/osdd-cli/releases/download/v#{version}/osdd-darwin-amd64.tar.gz"
      sha256 "17600c994bf66c729740e0b05d15853908fbeb53c9ed4abae0e7239465173d74"
    end
  end

  def install
    bin.install Dir["osdd-*"].first => "osdd"
  end

  test do
    system "#{bin}/osdd", "version"
  end
end
