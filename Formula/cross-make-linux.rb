class CrossMakeLinux < Formula
  desc "Compile linux kernel from macOS directly (w/o VM or docker image)"
  homepage "https://github.com/archie2x/cross-make-linux"
  url "https://github.com/archie2x/cross-make-linux/archive/refs/tags/" \
      "v0.1.0.tar.gz"
  sha256 "8cf260216fcfc4b66d4f830d956f12b473a4da79e24a6fe29e9395cbe2e84b65"
  license "MIT"

  on_macos do
    depends_on "coreutils"
    depends_on "findutils"
    depends_on "gnu-sed"
    depends_on "make"
    depends_on "pkg-config"
  end

  def install
    odie "cross-make-linux is only supported on macOS." if OS.linux?

    bin.install "bin/cross-make-linux"

    include_dir = libexec/"include/cross-make-linux"
    include_dir.install Dir["include/cross-make-linux/*"]
  end

  test do
    skip "cross-make-linux is only supported on macOS." if OS.linux?

    system "#{bin}/cross-make-linux", "-h"
  end
end
