class OutlineMcp < Formula
  desc "Tree-structured session guide & checklist as an MCP server"
  homepage "https://github.com/ynishi/outline-mcp"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.13.0/outline-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "92d1fb0ad26188a3e4c4720d5074ddabfd5e15fc248cc2ecbe5127d5efdf7fda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.13.0/outline-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "45bc7acf2e7424ad3133e887bd1470923489baed3676b19be81eb76b84b78ed9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.13.0/outline-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "637a7e2fa39fb1f68bf3cba3cd54240a232552a3910a9e182f6f30f32e02125c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ynishi/outline-mcp/releases/download/v0.13.0/outline-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa27fca5ac0715650790848f2dac2862e43dd41f6f2fb50b6b796ded8961ebb4"
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
