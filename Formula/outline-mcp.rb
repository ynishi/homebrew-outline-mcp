class OutlineMcp < Formula
  desc "Tree-structured session guide & checklist as an MCP server"
  homepage "https://github.com/ynishi/outline-mcp"
  version "0.15.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.2/outline-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "1c5191765ae27b8b1ee5dc0774c46de6468be9653d91a96eb19892a09f2051a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.2/outline-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "f94d4f11b03567bc0fd097ec9e1f24cc23e0b734aba8797b6e27110e63fab73b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.2/outline-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e9ee8d4b9c2ed6c45520bf2ffe32e01f8365d24c68b4008fd8c029efae76315c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.2/outline-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6c41ece342880aa821b3a47e764e01a8ee333248fd641c21b1db84a8ac74585e"
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
