class VorbisTools < Formula
  desc "Ogg Vorbis CODEC tools"
  homepage "https://github.com/xiph/vorbis-tools"
  url "https://downloads.xiph.org/releases/vorbis/vorbis-tools-1.4.0.tar.gz"
  sha256 "a389395baa43f8e5a796c99daf62397e435a7e73531c9f44d9084055a05d22bc"
  revision 1

  bottle do
    rebuild 1
    sha256 "92c11dabfc26b7fd84178700b02329fac05ab8eaff5eb55a613132ad93fe8e65" => :mojave
    sha256 "b764cae12c12c9338b96023d5e855aa6f39b989c19dea650d43edc219135b17d" => :high_sierra
    sha256 "a062b8dbfe05458dc18c311b16260da2ae12b00b3537643b4336094d731f8808" => :sierra
    sha256 "5ec349e8c68d23599b9e3185c6b8b1a6a3294d3f0056b740e7b29f141a4c70b3" => :el_capitan
    sha256 "643822a271f6748dc635cede3cdf7b53558cc25f4663014006d46cda817a7c8c" => :yosemite
    sha256 "73423823af88d4de39b609a847461c1d6e336407f2c0994851f6c24aa23532df" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "libao"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "flac" => :optional
  depends_on "curl" unless OS.mac?

  def install
    # Fix `brew linkage --test` "Missing libraries: /usr/lib/libnetwork.dylib"
    # Prevent bogus linkage to the libnetwork.tbd in Xcode 7's SDK
    ENV.delete("SDKROOT") if OS.mac? && MacOS.version == :yosemite

    # Fixes: /usr/bin/ld: vgfilter.o: undefined reference to symbol 'tanh@@GLIBC_2.2.5'
    ENV.prepend "LDFLAGS", "-lm" unless OS.mac?

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-nls
      --prefix=#{prefix}
    ]

    args << "--without-flac" if build.without? "flac"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"oggenc", test_fixtures("test.wav"), "-o", "test.ogg"
    assert_predicate testpath/"test.ogg", :exist?
    output = shell_output("#{bin}/ogginfo test.ogg")
    assert_match "20.625000 kb/s", output
  end
end
