class OutlineMcp < Formula
  desc "Tree-structured session guide & checklist as an MCP server"
  homepage "https://github.com/ynishi/outline-mcp"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.12.0/outline-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "0ae70c7e7624e17bc7b493da7a705fcbe3e9b159cdbc96f4a15e54ccc2f381a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.12.0/outline-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "a762b60ff0a08c47c9c62f9024972cdc4001cde0f5a933055288fad93204b4a0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.12.0/outline-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e9d7963235e81456971143320243625725472a63b98827507186d605d211451"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.12.0/outline-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "18175254174bd33d94f934819e356b30040d1355c1372900c6a00ec23fc0c7ff"
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
