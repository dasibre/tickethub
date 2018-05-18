require 'test_helper'

class HashExtension::Hash::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, HashExtension
  end

  test "missing value" do
  	h = Hash.new
  	p h
  	assert_nil h.baz!
  end
end
