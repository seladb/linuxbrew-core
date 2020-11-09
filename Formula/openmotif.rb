class Openmotif < Formula
  desc "LGPL release of the Motif toolkit"
  homepage "https://motif.ics.com/motif"
  url "https://downloads.sourceforge.net/project/motif/Motif%202.3.8%20Source%20Code/motif-2.3.8.tar.gz"
  sha256 "859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7"
  license "LGPL-2.1-or-later"
  revision OS.mac? ? 1 : 3

  livecheck do
    url :stable
  end

  bottle do
    sha256 "07edf35230c5dca07fd5b4aa3a198d9ec706319e9b57ae62259f63d9726262f7" => :catalina
    sha256 "b921f9634055bd7aaab722d156feca35da0742106036f23837241d53d1380648" => :mojave
    sha256 "0ebe3e7a88d400291a3e0a3f46d40b500c1e0487f5f689535c8c468993e786da" => :high_sierra
  end

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "jpeg"
  depends_on "libice"
  depends_on "libpng"
  depends_on "libsm"
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxft"
  depends_on "libxmu"
  depends_on "libxp"
  depends_on "libxt"
  depends_on "xbitmaps"

  depends_on "flex" => :build unless OS.mac?

  conflicts_with "lesstif",
    because: "both Lesstif and Openmotif are complete replacements for each other"

  def install
    unless OS.mac?
      inreplace ["demos/programs/Exm/simple_app/Makefile.am", "demos/programs/Exm/simple_app/Makefile.in"],
        /(LDADD.*\n.*libExm.a)/,
        "\\1 -lX11"
    end
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make"
    system "make", "install"

    # Avoid conflict with Perl
    mv man3/"Core.3", man3/"openmotif-Core.3"
  end

  test do
    assert_match /no source file specified/, pipe_output("#{bin}/uil 2>&1")
  end
end
