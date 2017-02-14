# Bundler::GemVersionTasks
![travis status](https://travis-ci.org/yarmand/bundler-gem_version_tasks.svg?branch=master)

I have always use [jeweler](https://github.com/technicalpickles/jeweler) to develop my gems.
I decided recently to simply rely on bundler but I missed so much the
helper rake tasks to manage version that I reimplemented for bundler.

## Installation

Add this gem (bundler-gem_version_tasks) as a development dependency in
your gemspec:

```
spec.add_development_dependency 'bundler-gem_version_tasks'
```

Add this to your Rakefile, instead of require 'bundler/gem_tasks':

```
require "bundler/gem_version_tasks"
```
## Usage

```
rake version             # print current version
rake version:bump:major  # Bump the major version by 1
rake version:bump:minor  # Bump the minor version by 1
rake version:bump:patch  # Bump the patch version by 1
rake version:write       # write a specific version - example: rake version:write VERSION=1.2.3
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bundler-gem_version_tasks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
