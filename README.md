# Quipper Rubocop Configs

Adds Rubocop and holds the default rubocop config for Quipper that can be shared in any ruby repo.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quipper-rubocop-config'
```

And then execute:

  `$ bundle install`

$$ Usage

Then using the command line client you can use:

  `$ bundle exec quipper-rubocop-config install`

Which will automatically install the `.rubocop.yml` which holds the configs.


### Adding it into a legacy application

Additionally if this is being installed into a legacy repo or one that already has a lot of files (and thus rubocop errors) you can run:

`$ bundle exec quipper-rubocop-config --with_todo`

 This installs the `.rubocop_todo.yml` file which lists the rules that are currently broken but which you might want to fix later and tells rubocop to ignore them for now.

## Prepush hook

If you want to run rubocop before pushing there is a prepush hook which you can install.

  `$ bundle exec quipper-rubocop-config install_prepush`

This installs a prepush in `.git/hooks` folder so if you already have a `pre-push` file you won't be able to use it.
If you want the fancy ability to autocorrect and commit your changes as well you can set `export RUBO_AUTOCORRECT=true` as an environment variable.

## Changing or adding a rule
Please edit this file:

https://github.com/quipper/quipper-rubocop-config/blob/master/config/rubocop.yml

## Uninstall 

To remove this gem and all created files simply run:
  `$ bundle exec quipper-rubocop-config uninstall`

and then remove the Gem from your Gemfile.
