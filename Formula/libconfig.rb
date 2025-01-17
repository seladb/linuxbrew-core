class Libconfig < Formula
  desc "Configuration file processing library"
  homepage "https://hyperrealm.github.io/libconfig/"
  url "https://github.com/hyperrealm/libconfig/archive/v1.7.3.tar.gz"
  sha256 "68757e37c567fd026330c8a8449aa5f9cac08a642f213f2687186b903bd7e94e"
  license "LGPL-2.1-or-later"
  head "https://github.com/hyperrealm/libconfig.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "e675d6e4c47ca13fe8a8faaf02364c5e09c43f7212b33040aa49c06a808c077c"
    sha256 cellar: :any,                 big_sur:       "90fad29e719a3bd1b8ebe4eb857299b8a78a229543c3062d370bcdcfa0b8cd5c"
    sha256 cellar: :any,                 catalina:      "88689325264c406acb9f624b0c66cae10e2c7b5874b4d78335751b4627a5496c"
    sha256 cellar: :any,                 mojave:        "f5470e709146445744e2f9a200e0ea8042be9cd144a3e0b9f0a664b07e1aadc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04cac7af8139904ae1d9f0b68e31f91239ef512b9cdacee447ad97fd5bff67a0"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  uses_from_macos "flex" => :build
  uses_from_macos "texinfo" => :build

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libconfig.h>
      int main() {
        config_t cfg;
        config_init(&cfg);
        config_destroy(&cfg);
        return 0;
      }
    EOS
    system ENV.cc, testpath/"test.c", "-I#{include}",
           "-L#{lib}", "-lconfig", "-o", testpath/"test"
    system "./test"
  end
end
