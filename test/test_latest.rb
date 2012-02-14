require "minitest/autorun"
require "latest"

class TestLatest < MiniTest::Unit::TestCase
  
  BIN = File.expand_path("../../bin/latest", __FILE__)
  
  STABLE_VERSION_REGEX     = /\d+(\.\d+)*$/                       # 11.2.123
  PRERELEASE_VERSION_REGEX = /--pre \d+(\.\d+)*(.[a-z\.\d]+)+$/i  # 0.1.23.beta.1

  def assert_version_match(name, string, prerelease=false)
    assert_match Regexp.new("#{name} #{prerelease ? PRERELEASE_VERSION_REGEX : STABLE_VERSION_REGEX}"), string.strip
  end

  def test_has_version
    assert_equal String, Latest::VERSION.class
  end

  def test_executable_exists
    assert File.exists?(BIN)
  end
  
  def test_executable_is_executable
    assert File.executable?(BIN)
  end
  
  def test_executable_returns_version
    out = `#{BIN} -v`
    assert_match "Latest v#{Latest::VERSION}", out
  end
  
  def test_executable_fetches_and_prints_version
    out = `#{BIN} rake`
    assert_version_match "rake", out
  end
  
  def test_executable_fetches_and_prints_multiple_versions
    out = `#{BIN} rake rails spree`.split("\n")
    assert_version_match "rake",  out[0]
    assert_version_match "rails", out[1]
    assert_version_match "spree", out[2]
  end
  
  def test_executable_fetches_and_prints_prerelease_version
    out = `#{BIN} rake --pre`
    assert_version_match "rake", out, true
  end
  
  def test_executable_fetches_and_prints_multiple_prerelease_versions
    out = `#{BIN} rake --pre rails --pre spree`.split("\n")
    assert_version_match "rake",  out[0], true
    assert_version_match "rails", out[1], true
    assert_version_match "spree", out[2]
  end
  
end
