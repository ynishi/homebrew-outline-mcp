class OutlineMcp < Formula
  desc "Tree-structured session guide & checklist as an MCP server"
  homepage "https://github.com/ynishi/outline-mcp"
  version "0.15.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.3/outline-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "6430a471321a928388ca018847407bb637599712ac544faef01e50a157619930"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.3/outline-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "b96f16b5ab7501743028602ef34f0ca30a6ee9abf304ef7bea27bf2aa19b24ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.3/outline-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ad49a4142ded3b48047dafaf9d57ed0059fa9601a0ad140d5fe2ae7184566bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.15.3/outline-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "966876d1f58cad4b7d00cb1c158d38ae7c996cd7b1ed2f0f33a9021ea4178d3f"
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
