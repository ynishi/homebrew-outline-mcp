class OutlineMcp < Formula
  desc "Tree-structured session guide & checklist as an MCP server"
  homepage "https://github.com/ynishi/outline-mcp"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.0/outline-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6f0607607285075ba3c3651e67099034a9ce5cd46bd7e3dd7d493cf4dbcd483f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.0/outline-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "3f92d1082441124f87c033df35d4f24116a85b00a1279ba78071898a62af4e17"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.0/outline-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c775868f3e0a4cbc874f29231b4b94b4d3d6c8b72d11292fd188253a4e42d549"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.0/outline-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "18fd33ac73dde88ed6c239fcd15c5c2aaec2e6f67bdabb61d19251b1617ef96e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "outline-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "outline-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "outline-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "outline-mcp"
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
