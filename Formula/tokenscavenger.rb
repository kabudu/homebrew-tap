class Tokenscavenger < Formula
  desc "Self-hosted OpenAI-compatible LLM proxy/router"
  homepage "https://github.com/kabudu/token-scavenger"

  on_macos do
    on_arm do
      url "https://github.com/kabudu/token-scavenger/releases/download/v0.4.0/tokenscavenger-v0.4.0-aarch64-apple-darwin.zip"
      sha256 "4fa26bf95a386d66b3af764ab56330b32eb5bd907cbfbae0867a7c46cc86c8a6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kabudu/token-scavenger/releases/download/v0.4.0/tokenscavenger-v0.4.0-x86_64-unknown-linux-gnu"
      sha256 "abc5a49c92e104768e2f21024b959ee43c44d4142508c5225ca9bee0a9ff9c4a"
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
