require 'rubygems'
require 'bundler'
require 'minitest/autorun'
require 'minitest/rg'
require 'minitest/spec'
require 'gimme-double'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
