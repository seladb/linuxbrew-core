class Ctop < Formula
  desc "Top-like interface for container metrics"
  homepage "https://bcicen.github.io/ctop/"
  url "https://github.com/bcicen/ctop.git",
      tag:      "0.7.6",
      revision: "8f0c9f5048f455b72418625bb5687022a273bb44"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "92a1aa5a1b27ddcc1499d196a3e1e87f67a0bbf89664308b8dc009030cf29d5a"
    sha256 cellar: :any_skip_relocation, big_sur:       "c654814649f0fdefb159bda66af0926fe0615c6ac185f6234a88642e7add2947"
    sha256 cellar: :any_skip_relocation, catalina:      "517e520dc241ade15a6f493b394efa25e212e779ec2d6f1bfd6b9ecd0f0a9627"
    sha256 cellar: :any_skip_relocation, mojave:        "8186e049abc8b0e5f1253c5f310ffb6884b7defad2a8ed6fe50dceee573e5bcd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24170ce39945a417c46fd2a1719f4d7c7f8064df0b8372b4af94af673a4678e2"
  end

  depends_on "go" => :build

  def install
    system "make", "build"
    bin.install "ctop"
  end

  test do
    system "#{bin}/ctop", "-v"
  end
end
