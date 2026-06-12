class Asryx < Formula
  desc "Native voice-to-text toggle/CLI (offline, GGML Whisper)"
  homepage "https://github.com/bogdan-calapod/asryx-macos"
  url "https://github.com/bogdan-calapod/asryx-macos/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "b4f83d25954f06e63449a21a77edd5241c2a2e51201bf5c303bd1c056b0bbfd6"
  license "Apache-2.0"
  head "https://github.com/bogdan-calapod/asryx-macos.git", branch: "main"

  depends_on "cmake"      => :build
  depends_on "ninja"      => :build
  depends_on "pkg-config" => :build
  depends_on :macos       => :ventura

  resource "whisper-cpp" do
    url "https://github.com/ggerganov/whisper.cpp.git",
        revision: "040510a132f0a9b51d4692b57a6abfd8c9660696"
  end

  resource "sherpa-onnx" do
    url "https://github.com/k2-fsa/sherpa-onnx.git",
        revision: "13d0ae6c539d2809d32f5eaa3ef1db0c459d0b24"
  end

  def install
    (libexec/"whisper.cpp").mkpath
    resource("whisper-cpp").stage do
      cp_r ".", libexec/"whisper.cpp"
    end

    (libexec/"sherpa-onnx").mkpath
    resource("sherpa-onnx").stage do
      cp_r ".", libexec/"sherpa-onnx"
    end

    # Sherpa-onnx vendors several deps via FetchContent (json,
    # hclust_cpp, eigen, kaldi-decoder, ...). Homebrew traps these
    # by default; opting in here is the documented mechanism rather
    # than mirroring ~10 resources by hand.
    args = std_cmake_args + %W[
      -G Ninja
      -DCMAKE_BUILD_TYPE=Release
      -DCMAKE_OSX_DEPLOYMENT_TARGET=13.4
      -DHOMEBREW_ALLOW_FETCHCONTENT=ON
      -DASRYX_WHISPER_SOURCE_DIR=#{libexec}/whisper.cpp
      -DASRYX_WHISPER_SOURCE_DIR_DEFAULT=#{libexec}/whisper.cpp
      -DASRYX_SHERPA_SOURCE_DIR=#{libexec}/sherpa-onnx
      -DASRYX_SHERPA_SOURCE_DIR_DEFAULT=#{libexec}/sherpa-onnx
      -DGGML_CCACHE=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build", "--target", "asryx"
    bin.install "build/asryx"
  end

  def caveats
    <<~CAVEATS
      asryx stores user data under your home directory:
        ~/.local/share/asryx           downloaded GGML models
        ~/.local/share/asryx/diarize   downloaded diarization models
        ~/.cache/asryx                 cache
        ~/.asryx.conf                  config (written on first model install)
        /tmp/asryx-$UID                runtime state

      First-time setup (transcription model + speaker diarization models):

        asryx --model install base.en
        asryx --model use base.en
        asryx --diarize install pyannote-segmentation-3-0
        asryx --diarize install wespeaker-voxceleb-resnet34
        asryx status   # should print: idle

      Permissions (one-time, prompted on first toggle):

        - Microphone (your terminal app: Terminal.app, iTerm, Ghostty, ...)
        - Screen Recording (asryx itself)

      Both are required to capture and label the full conversation in
      calls (your voice + the other participants). Grant them in
      System Settings > Privacy & Security.

      If you'd rather skip Screen Recording entirely and only capture
      your microphone, add to ~/.asryx.conf:

        mic_only_fallback=true

      Output format: clipboard receives human-readable dialogue
      ("You: ...", "Speaker 1: ...") and pipe_to receives JSON
      conforming to asryx_schema_version 1.

      Bind 'asryx' to a hotkey via Karabiner-Elements, Hammerspoon, Raycast,
      or skhd to toggle recording and transcription.
    CAVEATS
  end

  test do
    ENV["HOME"] = testpath
    assert_match "idle", shell_output("#{bin}/asryx status")
  end
end
