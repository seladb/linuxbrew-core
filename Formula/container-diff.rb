class ContainerDiff < Formula
  desc "Diff your Docker containers"
  homepage "https://github.com/GoogleContainerTools/container-diff"
  url "https://github.com/GoogleContainerTools/container-diff/archive/v0.17.0.tar.gz"
  sha256 "b1d909c4eff0e3355ba45516daddef0adfa4cdcd0c8b41863060c66f524353f9"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e41a2030963aa17e984e444844f065e21f3db400500602dd9fb70c15fab6efd3"
    sha256 cellar: :any_skip_relocation, big_sur:       "339c0ec5e9dbe0b5255a3ca87c316cc159741bb7b6ae43189a9d20af8fb5a63e"
    sha256 cellar: :any_skip_relocation, catalina:      "7b09d72b8cea67e283520a37ffb5082b7070443a5da1f78584270488ea6f8f74"
    sha256 cellar: :any_skip_relocation, mojave:        "4c9f7078b38379711d7eb961e9ed670a13a3240ce0c1d99d910d8313daa412bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8349134faa66458a6f432c65408625f6677ad22b0364cee936d82fcca60f3b9"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/GoogleContainerTools/container-diff/version"
    system "go", "build", *std_go_args, "-ldflags", "-s -w -X #{pkg}.version=#{version}"
  end

  test do
    image = "daemon://gcr.io/google-appengine/golang:2018-01-04_15_24"
    output = shell_output("#{bin}/container-diff analyze #{image} 2>&1", 1)
    assert_match "error retrieving image daemon://gcr.io/google-appengine/golang:2018-01-04_15_24", output
  end
end
