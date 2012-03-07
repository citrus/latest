require "latest"
require "minitest/autorun"

describe "Latest" do

  BIN = File.expand_path("../../bin/latest", __FILE__)
  STABLE_VERSION_REGEX = /\d+(\.\d+)*/                        # 11.2.123
  PRE_VERSION_REGEX    = /--pre \d+(\.\d+)*(.[a-z\.?\d]+)+/i  # 0.1.23.beta.1
  DOWNLOADS_REGEX      = /\(\d+ downloads\)/

  def assert_version_match(name, string, prerelease=false)
    regex = Regexp.new("#{name} #{prerelease ? PRE_VERSION_REGEX : STABLE_VERSION_REGEX} #{DOWNLOADS_REGEX}")
    string.strip.must_match regex 
  end

  it "should have a version constant" do
    assert Latest.const_defined?(:VERSION)
  end
  
  it "should have a latest executable" do
    assert File.exists?(BIN)
    assert File.executable?(BIN)
  end
  
  describe "#latest" do
    
    def cmd(params)
      `#{BIN} #{params}`.strip
    end
    
    it "should return version with -v or --version" do
      expected = "Latest v#{Latest::VERSION}"
      cmd("-v").must_equal expected
      cmd("--version").must_equal expected
    end
     
    it "should fetch and print multiple gems" do
      out = cmd("rake minitest latest").split("\n")
      assert_version_match "rake",     out[0]
      assert_version_match "minitest", out[1]
      assert_version_match "latest",   out[2]
    end
    
    it "should fetch and print prerelease version" do
      out = cmd("rake --pre")
      assert_version_match "rake", out, true
    end
    
    it "should fetch and print mixed normal and prerelease versions" do
      out = cmd("rake --pre shoulda --pre latest").split("\n")
      assert_version_match "rake",    out[0], true
      assert_version_match "shoulda", out[1], true
      assert_version_match "latest",  out[2]
    end
  
    
    
    #it "should fetch gem and print latest version" do
    #  cmd("rake").must_match /rake #{STABLE_VERSION_REGEX} \(\d+ downloads\)/
    #end
    #
    #it "should fetch gem and print latest version" do
    #  cmd("rake --pre").must_match /rake \d\.\d.\d.beta.\d \(\d+ downloads\)/
    #end
    #
    #it "should fetch gem and print latest version" do
    #  lines = cmd("rake --pre spree").split("\n")
    #  lines[0].must_match Regexp.new("rake #{PRE_VERSION_REGEX} \(\d+ downloads\)")
    #  lines[1].must_match Regexp.new("spree #{STABLE_VERSION_REGEX} \(\d+ downloads\)")
    #end
  
  end
  
end
