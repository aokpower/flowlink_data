# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'flowlink/version'

Gem::Specification.new do |s|
  s.name = "flowlink-data"
  s.version = Flowlink::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Cooper LeBrun"]
  s.email = ["cooperlebrun@gmail.com"]
  # s.homepage

  s.summary = "A simple framework for getting Flowlink objects from other sources."
  s.description = "A framework for getting Flowlink objects from other sources. For example:
  class Distributor::Product < Flowlink::Product
    def sku(hashable)
      # code that picks sku data out of a hashable object.
    end
  end
  Distributor::Product.new(CSV::Row).to_message #=> A bunch of NotImplementedError because just a sku is an invalid product"

  s.files = Dir.glob("{bin,lib}/**/*") # + %w(LICENSE README.md)
  # ROADMAP.md CHANGELOG.md

  s.license = 'MIT'

  s.require_path = 'lib'
end
