class SimpleHttptap < Formula
  desc "An ephemeral HTTPS-intercepting proxy that writes every request and response, byte-exact, to stdout as NDJSON."
  homepage "https://github.com/stack1ng/simple-httptap"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.3/simple-httptap-proxy-tokio-aarch64-apple-darwin.tar.xz"
      sha256 "6a20a764cd0815ca9a618b5b5e235d79682f3a2dd92aeb8defbf9674d89b95c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.3/simple-httptap-proxy-tokio-x86_64-apple-darwin.tar.xz"
      sha256 "b198eea8aa84d696420a51b2d89f3fe2e0bff6ebc477e2da312ec75173041594"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.3/simple-httptap-proxy-tokio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4f9be71cd14efcd4fcff4fef150cfb61d24abdea51880c51c27e1150db52823c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stack1ng/simple-httptap/releases/download/v0.0.3/simple-httptap-proxy-tokio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "975bb26b3a64ff581680eb90b8fd93c5f37121e15374e0d00737ac88bddb7e1f"
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
