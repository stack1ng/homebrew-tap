class SimpleHttptap < Formula
  desc "Runs a program with its traffic sent through a SOCKS5 proxy that decrypts TLS and QUIC with a key log and writes every request and response, byte-exact, to stdout as NDJSON."
  homepage "https://github.com/stack1ng/simple-httptap"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.1.0/simple-httptap-proxy-tokio-aarch64-apple-darwin.tar.xz"
      sha256 "0edecde84e01e5a60d13e2b02adcd706447681fa1db6ef0fd9ef922cbcf98059"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.1.0/simple-httptap-proxy-tokio-x86_64-apple-darwin.tar.xz"
      sha256 "d0532aa6f42d539a6b05bd2fd4e97a417c13818f1f28240c9758b64a2da8e573"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.1.0/simple-httptap-proxy-tokio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "60a7d31da31ea2145ed915e79117b4d8f7bf1fb624b84333ef22ad18613a04e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.1.0/simple-httptap-proxy-tokio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9d9c717f94bc685ccc04c6991969735edeb7fc3630896f169ec1b5b63facc662"
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
      bin.install "httptap"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "httptap"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "httptap"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "httptap"
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
