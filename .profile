# personal scripts
PATH=~/bin:$PATH

# local gem installation
export GEM_HOME=~/app/gems
mkdir -p $GEM_HOME

# local program installation
file=~/app/PATH.cache
test -s $file || cat > $file <<EOF
export PATH=\$PATH:$(
  ls -d ~/app/**/bin/ | fgrep -v "$GEM_HOME/gems" | tr '\n' ':' | sed 's,:$,,'
)
export MANPATH=\$MANPATH:$(
  ls -d ~/app/**/man/ | tr '\n' ':' | sed 's,:$,,'
)
EOF
source $file
