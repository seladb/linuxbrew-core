class Toast < Formula
  desc "Tool for running tasks in containers"
  homepage "https://github.com/stepchowfun/toast"
  url "https://github.com/stepchowfun/toast/archive/v0.33.0.tar.gz"
  sha256 "adf7c5b9f687598f1261f01db3a05b69a9973580303942a705bb192045d780c0"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9cfc5eec069aeddf79835a2732cd3419489344c5e5dbe520c3949b03aee46bd0"
    sha256 cellar: :any_skip_relocation, big_sur:       "edb05ec124d4088b868663aaf1b1ea47881a31bda07634e4d6291947b7dc9c87"
    sha256 cellar: :any_skip_relocation, catalina:      "971d49116b0892bf7e81bdc561264a314b1a9d55ea080c9337d4f0c4433b640d"
    sha256 cellar: :any_skip_relocation, mojave:        "0497bdf5f1a25cc6b547b6a7b150792138639ea525c4fcd364b7cff27a5317ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2718b877b27792832d42f98eea5252771286d66b59fcf75806cdb1b35710b11e"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"toast.yml").write <<~EOS
      image: alpine
      tasks:
        homebrew_test:
          command: echo hello
    EOS

    assert_match "homebrew_test", shell_output("#{bin}/toast --list")
  end
end
