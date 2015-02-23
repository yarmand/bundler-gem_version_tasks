require 'bundler/gem_tasks'
require "bundler/gem_version_tasks/version"

module Bundler
  class GemVersionTasks
    attr_reader :gemspec

    def initialize( opts={} )
      @gemspec     = opts.fetch(:gemspec) { Bundler::GemHelper.gemspec }
      @git_command = opts.fetch(:git_command, 'git')
    end

    def bump(what)
      major,minor,patch = version.segments
      case what
      when :major
        major += 1
        minor  = 0
        patch  = 0
      when :minor
        minor = minor.next
        patch = 0
      when :patch
        patch = patch.next
      else
        raise 'need to specify what to bump in :major, :minor, :patch'
      end
      "#{major}.#{minor}.#{patch}"
    end

    def replace_version(version_file, version)
      lines = File.readlines(version_file).map { |l| l.gsub(/\s*VERSION\s*=.*/,"VERSION='#{version}'") }
      File.open(version_file,'w') {|f| f.write(lines.join('')) }
      commit_version(version_file, "Bumping to version #{version}")
    end

    def commit_version(version_file, message)
      `#{@git_command} commit -m "#{message}" #{version_file}`
    end

    def version_file
      gemspec.files.grep(/\/version.rb$/).first
    end

    def version
      gemspec.version
    end

    def self.install!
      new.install
    end

    include Rake::DSL if defined? Rake::DSL
    def install
      desc "print current version"
      task 'version' do
        puts  version
      end

      namespace 'version' do
        desc "write a specific version - example: rake version:write VERSION=1.2.3"
        task 'write' do
          new_version = ENV['VERSION']
          replace_version(version_file, new_version)
        end
      end

      namespace 'version:bump' do
        desc "Bump the major version by 1"
        task 'major' do
          new_version = bump(:major)
          replace_version(version_file, new_version)
          puts  new_version
        end

        desc "Bump the minor version by 1"
        task 'minor' do
          new_version = bump(:minor)
          replace_version(version_file, new_version)
          puts  new_version
        end

        desc "Bump the patch version by 1"
        task 'patch' do
          new_version = bump(:patch)
          replace_version(version_file, new_version)
          puts  new_version
        end
      end
    end
    # Your code goes here...
  end
end

Bundler::GemVersionTasks.install! unless defined? Minitest
