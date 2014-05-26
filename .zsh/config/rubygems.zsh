# Configures RubyGems to install/search for gems in a local .rubygems/ folder,
# or $HOME/.rubygems/ if there is no Gemfile in the current working directory.
#
# See https://gist.github.com/thinkerbot/668037 for details of how this works:
#-----------------------------------------------------------------------------
# Two ENV variables control the 'gem' command:
#
#     GEM_HOME: the single path to a gem dir where gems are installed
#     GEM_PATH: a standard PATH to gem dirs where gems are found
#
# A gem directory is a directory that holds gems.  The 'gem'
# command will lay out and utilize the following structure:
#
#     bin               # installed bin scripts
#     cache             # .gem files  ex: cache/gem_name.gem
#     doc               # rdoc/ri     ex: doc/gem_name/rdoc
#     gems              # gem file    ex: gems/gem_name/lib/gem_name.rb
#     specifications    # gemspecs    ex: specifications/gem_name.gemspec
#
# As an example of usage:
#
#     export GEM_HOME=a
#     export GEM_PATH=a
#     gem install rack
#     gem list                    # shows rack
#
#     export GEM_HOME=b
#     export GEM_PATH=b
#     gem install rake
#     gem list                    # shows rake (not rack)
#
#     export GEM_PATH=a:b
#     gem list                    # shows rake and rack
#
# And if you set GEM_HOME=a:b, you will install into the 'a:b' directory :)
#-----------------------------------------------------------------------------

# Usage: rubygems_local_folder_helper PARENT_FOLDER_OF_GEM_HOME
function rubygems_local_folder_helper() {
  export GEM_HOME="$1/.rubygems"
  export GEM_PATH="$GEM_HOME:$GEM_PATH"
  export PATH="$GEM_HOME/bin:$PATH"
  mkdir -p "$GEM_HOME"
}

function rubygems_local_folder() {
  if test -d .rubygems -o -f Gemfile -o -f Gemfile.lock
  then rubygems_local_folder_helper "$PWD"
  elif test -z "$GEM_HOME"
  then rubygems_local_folder_helper "$HOME"
  fi
}

# run initially when this script is sourced at ZSH startup
rubygems_local_folder

# also run again whenever user changes working directory
chpwd_functions=(${chpwd_functions[@]} rubygems_local_folder)
