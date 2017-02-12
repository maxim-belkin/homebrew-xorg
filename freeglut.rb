# freeglut: Build a bottle for Linuxbrew
class Freeglut < Formula
  desc "Open-source clone of the GLUT library"
  homepage "http://freeglut.sourceforge.net/"
  url "https://downloads.sourceforge.net/freeglut/freeglut-3.0.0.tar.gz"
  sha256 "2a43be8515b01ea82bcfa17d29ae0d40bd128342f0930cd1f375f1ff999f76a2"

  option "with-static", "Build static libraries (not recommended)"
  option "with-demos", "Build optional demo programs (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "cmake" => :build
  depends_on "mesa"
  depends_on "glu" => :recommended

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DFREEGLUT_BUILD_STATIC_LIBS=#{build.with?("static") ? "ON" : "OFF"}"
    args << "-DFREEGLUT_BUILD_DEMOS=#{build.with?("demos") ? "ON" : "OFF"}"
    args << ".."

    (buildpath/"build").mkpath
    cd "build" do
      system "cmake", *args
      system "make"
      system "make", "install"
    end
  end
end
