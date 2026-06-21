class Tokenscavenger < Formula
  desc "Self-hosted OpenAI-compatible LLM proxy/router"
  homepage "https://github.com/kabudu/token-scavenger"

  on_macos do
    on_arm do
      url "https://github.com/kabudu/token-scavenger/releases/download/v0.3.7/tokenscavenger-v0.3.7-aarch64-apple-darwin.zip"
      sha256 "15dd039343a9c6d6e22a9122ea0eaac0d12b80eabfa5674321ff600e2c8383f3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kabudu/token-scavenger/releases/download/v0.3.7/tokenscavenger-v0.3.7-x86_64-unknown-linux-gnu"
      sha256 "9eaf0f8f44cc099b146e342977c67eedbe3699fb1102114f69db45b0370c0bc4"
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
