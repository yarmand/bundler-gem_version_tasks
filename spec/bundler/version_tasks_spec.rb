require_relative '../spec_helper'
require 'fileutils'
require 'bundler/gem_version_tasks'

module Bundler
  describe GemVersionTasks do

    subject { GemVersionTasks.new( gimme_gemspec, {:git_command => 'echo'}) }

    describe '#bump' do
      it 'should raise an exception if what is not specifyed properly' do
        lambda { subject.bump(:not_a_good_what) }.must_raise(RuntimeError)
      end

      it 'should bump major version' do
        subject.bump(:major).must_equal '2.0.0'
      end

      it 'should bump minor version' do
        subject.bump(:minor).must_equal '1.3.0'
      end

      it 'should bump patch version' do
        subject.bump(:patch).must_equal '1.2.4'
      end
    end

    describe '#version_file' do
      it 'retrieve the version.rb file' do
        subject.version_file.must_equal 'lib/bundler/yammer_gem_tasks/version.rb'
      end
    end

    describe '#replace_version' do
      before do
        @file_name = 'tmp_version.rb'
        system("cp spec/fixture/version.rb #{@file_name}")
      end

      it 'should write version in the version file' do
        subject.replace_version(@file_name,'50.49.48')
        vline = File.readlines(@file_name).grep(/VERSION/).first
        vline.must_match(/VERSION\s*=\s*'50.49.48'/)
      end

      after do
        FileUtils.rm @file_name
      end
    end

    private
    def gimme_gemspec
      gemspec = gimme
      give(gemspec).files { 
        ["Gemfile",
         "LICENSE.txt",
         "README.md",
         "lib/bundler/yammer_gem_tasks/version.rb",
         "bundler-yammer_gem_tasks.gemspec",
         "lib/bundler/yammer_gem_tasks.rb",
      ]
      }
      give(gemspec).version { Gem::Version.new('1.2.3a') }
      gemspec
    end

  end
end
