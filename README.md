## Pencil Durability Kata

# STEP 1: Installing Ruby
(I developed the kata using Ruby 2.5.1, but it should run fine with any version >= 2.3)
# -- Do this if you need to install a Ruby Version Manager
brew install rbenv
rbenv init
# --
rbenv install 2.5.1

## STEP 2: Dependencies (just rspec for testing)
# -- Do this if you need to install Bundler
gem install bundler
# --
bundle install

# Run Sample Program
ruby bin/writer-sample

# Run Tests
rspec



## --Notes on implementation design decisions-- ##
# Point Degradation
Cases outside uppercase, lowercase, and whitespace (e.g. special characters, etc.) were not mentioned in the prompt, so I'm assuming degrading by a point value of one for these cases is okay.

# Pencil.edit instance method
Edit will only edit text if the pencil is fully functional (i.e. neither the point nor eraser are dull).