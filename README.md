git-rails-jeansite
==================

## Installation

1. Install ruby 2.1.2
    1. (optional) Remove rvm `rvm implode`
    1. [Install rbenv](https://github.com/sstephenson/rbenv#installation)
    1. `rbenv install 2.1.2 && rbenv global 2.1.2`
1. Install bundler `gem install bundler && rbenv rehash`
1. `git clone https://github.com/jadekler/git-rails-jeansite.git`
1. `cd git-rails-jeansite`
1. `bundle install`

## Running the app

1. `rake db:migrate`
1. `rails s -p 3030`

## Running the tests

1. `rake test`