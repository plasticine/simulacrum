# encoding: UTF-8
puts '[Simplecov] enabled'
require 'simplecov'

SimpleCov.minimum_coverage 54.41
SimpleCov.refuse_coverage_drop
SimpleCov.start { add_filter '/spec/' }
