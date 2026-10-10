class Tokenscavenger < Formula
  desc "Self-hosted OpenAI-compatible LLM proxy/router"
  homepage "https://github.com/kabudu/token-scavenger"

  on_macos do
    on_arm do
      url "https://github.com/kabudu/token-scavenger/releases/download/v0.7.0/tokenscavenger-v0.7.0-aarch64-apple-darwin.zip"
      sha256 "a09eeec3dded368c4987fc7c0ced8005858f16e7712c2097ffe28afd83311939"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kabudu/token-scavenger/releases/download/v0.7.0/tokenscavenger-v0.7.0-x86_64-unknown-linux-gnu"
      sha256 "35a7c987919db14f41abd76f2adb00d80a001b41b98cc7848e582c628172b712"
    end
  end

  def install
    candidate = Dir["tokenscavenger*"].find { |path| File.file?(path) }
    odie "tokenscavenger release binary was not found" unless candidate

    bin.install candidate => "tokenscavenger"
  end

  service do
    run [opt_bin/"tokenscavenger", "--config", "#{etc}/tokenscavenger/tokenscavenger.toml"]
    keep_alive true
    working_dir var
    log_path var/"log/tokenscavenger.log"
    error_log_path var/"log/tokenscavenger.err.log"
  end

  test do
    assert_match "tokenscavenger", shell_output("#{bin}/tokenscavenger --help")
  end
end
