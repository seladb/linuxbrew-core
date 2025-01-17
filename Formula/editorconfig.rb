class Editorconfig < Formula
  desc "Maintain consistent coding style between multiple editors"
  homepage "https://editorconfig.org/"
  url "https://github.com/editorconfig/editorconfig-core-c/archive/v0.12.5.tar.gz"
  sha256 "b2b212e52e7ea6245e21eaf818ee458ba1c16117811a41e4998f3f2a1df298d2"
  license "BSD-2-Clause"
  head "https://github.com/editorconfig/editorconfig-core-c.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "8de5a49262229377ff5f97f670c729626c7c2a688c14cb901e1d6342eee99f92"
    sha256 cellar: :any,                 big_sur:       "35b906670a62d96a889967f904b9b157ca860f72993be36f4085081df24d23d1"
    sha256 cellar: :any,                 catalina:      "b6cac809fe16ed3e788d3bab017f128a6c960652104ed541791cca02b6e4bc16"
    sha256 cellar: :any,                 mojave:        "553e730194b67c667c214f992fd25bd44974d7c9f6812641be65c4347370c124"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0684baa132641725e9d48b0780ef4f9f742114e63992ae5558c9ad6a48fd10d2"
  end

  depends_on "cmake" => :build
  depends_on "pcre2"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/editorconfig", "--version"
  end
end
