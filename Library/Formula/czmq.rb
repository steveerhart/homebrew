require 'formula'

class Czmq < Formula
  homepage 'http://czmq.zeromq.org/'
  url 'http://download.zeromq.org/czmq-2.2.0.tar.gz'
  sha1 '8fc5038a8e086a8f0afa6d8f6beea2fe50525ecc'

  head do
    url 'https://github.com/zeromq/czmq.git'

    depends_on 'autoconf'
    depends_on 'automake'
    depends_on 'libtool'
  end

  option :universal

  depends_on 'zeromq'

  def install
    ENV.universal_binary if build.universal?
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
    rm Dir["#{bin}/*.gsl"]
  end

  test do
    bin.cd do
      system "#{bin}/czmq_selftest"
    end
  end
end
