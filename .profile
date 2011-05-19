# personal scripts
PATH=$HOME/bin:$PATH

# local installation
local_install_root=$HOME/app

# rubygems
export GEM_HOME=$local_install_root/rubygems
mkdir -p $GEM_HOME

# programs
file=$local_install_root/PATH
test ! -s $file -o $local_install_root -nt $file && cat > $file <<EOF
export PATH=\$PATH:$(
  find -L $local_install_root -type d -name bin | fgrep -v "$GEM_HOME/gems" |
  tr '\n' ':' | sed 's,:$,,'
)
export MANPATH=\$MANPATH:$(
  find -L $local_install_root -type d -name man | tr '\n' ':' | sed 's,:$,,'
)
EOF
source $file
