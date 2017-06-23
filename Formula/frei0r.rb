class Frei0r < Formula
  desc "Minimalistic plugin API for video effects"
  homepage "https://frei0r.dyne.org/"
  url "https://files.dyne.org/frei0r/releases/frei0r-plugins-1.4.tar.gz"
  sha256 "8470fcabde9f341b729be3be16385ffc8383d6f3328213907a43851b6e83be57"

  bottle do
    cellar :any_skip_relocation
    sha256 "49ad7fff938e08694ac11559d4b1cb5ad73e6ba88c2b6d3e22677891766e489d" => :sierra
    sha256 "960aa91d50697be5587a0124910d4c603354c3dfb660f9fc7dead6ea36d2140c" => :el_capitan
    sha256 "66426f87d88f4ea884ac74ba0a90d30433c4a00fc7295299bd15a960ef8807e3" => :yosemite
    sha256 "9e75c7883faa766b20f1d19c85eff4556039a49e65847806ef34cdae89f1c1ca" => :mavericks
    sha256 "a20918ebf08da3636deb4bb4c3bacaf395186f2bf88685ad8380d665e7402e24" => :mountain_lion
    sha256 "96d0ee05cd27d1a4983ae8f54109580b614ce2f7fe7f096d5a4049cedadc9bbc" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo" => :optional
  depends_on "homebrew/science/opencv" => :optional

  def install
    ENV["CAIRO_CFLAGS"] = "-I#{Formula["cairo"].opt_include}/cairo" if build.with? "cairo"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
