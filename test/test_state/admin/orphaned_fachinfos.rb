#!/usr/bin/env ruby
# ODDB::State::Admin::TestOrphanedFachinfos -- oddb.org -- 01.07.2011 -- mhatakeyama@ywesee.com

$: << File.expand_path("../../../src", File.dirname(__FILE__))


require 'test/unit'
require 'flexmock'
require 'state/admin/orphaned_fachinfos'

module ODDB
  module State
    module Admin

class TestOrphanedFachinfos < Test::Unit::TestCase
  include FlexMock::TestCase
  def setup
    @lnf     = flexmock('lookandfeel', :lookup => 'lookup')
    @session = flexmock('session', :lookandfeel => @lnf)
    @model   = flexmock('model', :size => 1)
    @state   = ODDB::State::Admin::OrphanedFachinfos.new(@session, @model)
  end
  def test_init
    assert_equal(nil, @state.init)
  end
  def test_symbol
    assert_equal(:name, @state.symbol)
  end
end

    end # Admin
  end # State
end # ODDB
