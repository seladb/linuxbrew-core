class Shelltestrunner < Formula
  desc "Portable command-line tool for testing command-line programs"
  homepage "https://github.com/simonmichael/shelltestrunner"
  url "https://hackage.haskell.org/package/shelltestrunner-1.9/shelltestrunner-1.9.tar.gz"
  sha256 "cbc4358d447e32babe4572cda0d530c648cc4c67805f9f88002999c717feb3a8"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "58f03249e05d5808baff4da11f784b37bd818f35c3243855bdc467562526ff76"
    sha256 cellar: :any_skip_relocation, big_sur:       "e42bf02d5f462aca20fe7a9b80ba6e2431b15940b81f5304ff1611665a29bac0"
    sha256 cellar: :any_skip_relocation, catalina:      "d425959bf27c059fb22a6e2f916f839645c0e79f180903b2c99c189ba52f4d96"
    sha256 cellar: :any_skip_relocation, mojave:        "15ccce4fe40fe20c6f9c97442fb37079a6925351f725d4e6840541004375520c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e5401607be2561a955df96ff4f19413764f68e42f16e6554841735a4901837b1"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"test").write "$$$ {exe} {in}\n>>> /{out}/\n>>>= 0"
    args = "-D{exe}=echo -D{in}=message -D{out}=message -D{doNotExist}=null"
    assert_match "Passed", shell_output("#{bin}/shelltest #{args} test")
  end
end
