class Ntl < Formula
  desc "C++ number theory library"
  homepage "https://libntl.org"
  url "https://libntl.org/ntl-11.5.1.tar.gz"
  sha256 "210d06c31306cbc6eaf6814453c56c776d9d8e8df36d74eb306f6a523d1c6a8a"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://libntl.org/download.html"
    regex(/href=.*?ntl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "972f6f6fdf45e71f8d852a5ab162189f14bb1f800692af4466b5672e75ff62cd"
    sha256 cellar: :any,                 big_sur:       "e108c06f39537cdc58cd6e7f681395ae069c381af5e0c95abca97d1ccc90ec9e"
    sha256 cellar: :any,                 catalina:      "b97739b3b8de3daabe0d76cec3e29ef47f4bc85e6197054aec6d10f6b8f1a4ae"
    sha256 cellar: :any,                 mojave:        "bc2ffa687c16e3ee99c093dc0b55275df08c278e20c1d2281e798f1144816634"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "907d548b5c3e9123529c725d297488772354ab8278cd55f28b3bb5050722eb30"
  end

  depends_on "gmp"

  def install
    args = ["PREFIX=#{prefix}", "SHARED=on"]

    cd "src" do
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"square.cc").write <<~EOS
      #include <iostream>
      #include <NTL/ZZ.h>

      int main()
      {
          NTL::ZZ a;
          std::cin >> a;
          std::cout << NTL::power(a, 2);
          return 0;
      }
    EOS
    gmp = Formula["gmp"]
    flags = %W[
      -std=c++11
      -I#{include}
      -L#{gmp.opt_lib}
      -L#{lib}
      -lntl
      -lgmp
      -lpthread
    ]
    system ENV.cxx, "square.cc", "-o", "square", *flags
    assert_equal "4611686018427387904", pipe_output("./square", "2147483648")
  end
end
