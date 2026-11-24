class SimpleHttptap < Formula
  desc "An ephemeral HTTPS-intercepting proxy that writes every request and response, byte-exact, to stdout as NDJSON."
  homepage "https://github.com/stack1ng/simple-httptap"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.1/simple-httptap-proxy-tokio-aarch64-apple-darwin.tar.xz"
      sha256 "3b3c393e7415aec55d3001c452a9653742a8d5d060f9b6039a732b8ce94c7a44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.1/simple-httptap-proxy-tokio-x86_64-apple-darwin.tar.xz"
      sha256 "a646cb5956305f634fb0f53b2446085beebfc2e4011ad1ece03364f72bcaa0ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.1/simple-httptap-proxy-tokio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "172e92af685c5310fd4c728d7ce3c7e37dd8fdf8ef1a139d391c514fc081cefb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.1/simple-httptap-proxy-tokio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d705d374a24575219650f9aeea904c7cca1828ffa020ce4d8353e9e69f8c7de5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "simple-httptap"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "simple-httptap"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "simple-httptap"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "simple-httptap"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
