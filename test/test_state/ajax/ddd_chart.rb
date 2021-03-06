#!/usr/bin/env ruby
# encoding: utf-8
# ODDB::State::Ajax::TestDDDChart -- oddb.org -- 01.07.2011 -- mhatakeyama@ywesee.com

$: << File.expand_path("../../../src", File.dirname(__FILE__))


require 'minitest/autorun'
require 'flexmock/minitest'
require 'sbsm/state'
require 'state/ajax/ddd_chart'

module ODDB
  module State
    module Ajax

class TestDDDChart <Minitest::Test
  def setup
    @lnf     = flexmock('lookandfeel', :lookup => 'lookup')
    @comparable = flexmock('comparable', 
                          :ddd_price => 'ddd_price',
                          :name_base => 'name_base',
                          :ref_data_listed?  => true,
                          :pointer => 'comparable.pointer',
                          :size => 'size'
                         )
    sequence = flexmock('sequence', :comparables => [@comparable])
    @package = flexmock('package', 
                        :generic_group_comparables => [@comparable],
                        :sequence  => sequence,
                        :ddd_price => 'ddd_price',
                        :name_base => 'name_base',
                        :size => 'size',
                        :pointer => 'pointer',
                       )
    @package.should_receive(:ref_data_listed? ).and_return(true).by_default
    flexmock(@comparable, :public_packages => [@package])
    flexmock(sequence, :public_packages => [@package])
    registration = flexmock('registration', :package => @package)
    @session = flexmock('session', 
                        :lookandfeel  => @lnf,
                        :user_input   => '12345123',
                        :registration => registration
                       )
    @model   = flexmock('model')
    @state   = ODDB::State::Ajax::DDDChart.new(@session, @model)
  end
  def test_init
    expected = [@comparable, @package]
    assert_equal(expected, @state.init)
  end
  def test_not_active
    @package.should_receive(:ref_data_listed?).and_return(false)
    expected = [@comparable]
    assert_equal(expected, @state.init)
  end
end

    end # Ajax
  end # State
end # ODDB
