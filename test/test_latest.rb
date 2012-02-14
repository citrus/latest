require "minitest/autorun"
require "latest"

class TestLatest < MiniTest::Unit::TestCase
  
  BIN = File.expand_path("../../bin/latest", __FILE__)

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
    assert_match /rake \d.\d.\d(.\d)?/, out
  end
  
  def test_executable_fetches_and_prints_multiple_versions
    out = `#{BIN} rake rails spree`.split("\n")
    assert_match /rake \d.\d.\d(.\d)?/,  out[0]
    assert_match /rails \d.\d.\d(.\d)?/, out[1]
    assert_match /spree \d.\d.\d(.\d)?/, out[2]
  end
  
end
