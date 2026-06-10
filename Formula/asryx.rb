class Asryx < Formula
  desc "Native voice-to-text toggle/CLI (offline, GGML Whisper)"
  homepage "https://github.com/bogdan-calapod/asryx-macos"
  url "https://github.com/bogdan-calapod/asryx-macos/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "493ec1b101d1547abbb331c3e963f50e0a8f6762fa0d88a830304e33b075a177"
  license "Apache-2.0"
  head "https://github.com/bogdan-calapod/asryx-macos.git", branch: "main"

  depends_on "cmake"      => :build
  depends_on "ninja"      => :build
  depends_on "pkg-config" => :build
  depends_on "sox"

  resource "whisper-cpp" do
    url "https://github.com/ggerganov/whisper.cpp.git",
        revision: "040510a132f0a9b51d4692b57a6abfd8c9660696"
  end

  def install
    (libexec/"whisper.cpp").mkpath
    resource("whisper-cpp").stage do
      cp_r ".", libexec/"whisper.cpp"
    end

    args = std_cmake_args + %W[
      -G Ninja
      -DCMAKE_BUILD_TYPE=Release
      -DASRYX_WHISPER_SOURCE_DIR=#{libexec}/whisper.cpp
      -DASRYX_WHISPER_SOURCE_DIR_DEFAULT=#{libexec}/whisper.cpp
      -DGGML_CCACHE=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build", "--target", "asryx"
    bin.install "build/asryx"
  end

  def caveats
    <<~EOS
      asryx stores user data under your home directory:
        ~/.local/share/asryx           downloaded GGML models
        ~/.cache/asryx                 cache
        ~/.asryx.conf                  config (written on first model install)
        /tmp/asryx-$UID                runtime state

      First-time setup:

        asryx --model install base.en
        asryx --model use base.en
        asryx status   # should print: idle

      On first invocation, macOS will prompt your terminal application
      (Terminal.app, iTerm, Ghostty, etc.) for microphone access.
      Grant it in System Settings > Privacy & Security > Microphone.

      Bind 'asryx' to a hotkey via Karabiner-Elements, Hammerspoon, Raycast,
      or skhd to toggle recording and transcription.
    EOS
  end

  test do
    ENV["HOME"] = testpath
    assert_match "idle", shell_output("#{bin}/asryx status")
  end
end
