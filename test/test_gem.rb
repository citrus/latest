require "minitest/autorun"
require "latest"

class TestGem < MiniTest::Unit::TestCase
  
  def test_should_fetch_on_initialize
    gem = ::Latest::Gem.new("rake")
    assert_equal Hash, gem.attributes.class
    assert_equal "rake", gem.attributes["name"]
  end
  
  def test_raise_error_when_gem_is_not_found
    assert_raises Latest::GemNotFoundError do
      ::Latest::Gem.new("some-gem-that-probably-wont-exist-2")
    end
  end
  
end
