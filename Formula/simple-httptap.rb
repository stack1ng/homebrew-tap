class SimpleHttptap < Formula
  desc "An ephemeral HTTPS-intercepting proxy that writes every request and response, byte-exact, to stdout as NDJSON."
  homepage "https://github.com/stack1ng/simple-httptap"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.2/simple-httptap-proxy-tokio-aarch64-apple-darwin.tar.xz"
      sha256 "d46d4887cfa14ac3a14cf980d0ccfa13912be6cafa6314a8a4f0a9ba2c3b5b5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.2/simple-httptap-proxy-tokio-x86_64-apple-darwin.tar.xz"
      sha256 "bb207fbc7baf0b7c6eff098e9f01e6ba90f2d0703fd40e17205241a1c2b74a84"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.2/simple-httptap-proxy-tokio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7431f92dd5aabf325efe53b2d55f4e9bfe5b67a573e56662205880b9de1ae0b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.2/simple-httptap-proxy-tokio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "87fde931af2a5f926ed157f6badf1a47bcb74aae4b9b3ed23aa7633cf651194b"
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
