class CrossMakeLinux < Formula
  desc "Compile linux kernel from macOS directly (w/o VM or docker image)"
  homepage "https://github.com/archie2x/cross-make-linux"
  url "https://github.com/archie2x/cross-make-linux/archive/refs/tags/" \
      "v0.2.0.tar.gz"
  sha256 "12976b8c730d3be397c464d704c445ffab6dde6e12590fba516439601c5d12af"
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
    (libexec/"bin").install "bin/create-case-sensitive.sh"

    include_dir = libexec/"include/cross-make-linux"
    include_dir.install Dir["include/cross-make-linux/*"]
  end

  def caveats
    <<~EOS
    kernel builds require a case-sensitive volume.

    A helper script is bundled to create and mount one:
      #{opt_libexec}/bin/create-case-sensitive.sh

    You’ll likely only need to run it once.

    Example:
      # creates volume named 'case-senstive' and mount at ~/cs-src
      $(brew --prefix cross-make-linux)/bin/create-case-sensitive.sh case-sensitive ~/cs-src
      git clone rpi-6.12.y https://github.com/raspberrypi/linux ~/cs-src/rpi-linux
      cd ~/cs-src/rpi-linux
      export LLVM=1 ARCH=arm64
      cross-make-linux bcm2712_oldconfig
      cross-make-linux Image.gz modules dtbs
  EOS
  end

  test do
    skip "cross-make-linux is only supported on macOS." if OS.linux?

    system "#{bin}/cross-make-linux", "-h"
  end
end
