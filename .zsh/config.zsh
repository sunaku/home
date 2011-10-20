# delegate configuration
for file in ~/.zsh/config/**/*.zsh; do
  source $file
done

# load plugin bundles
for bundle in ~/.zsh/bundle/*; do
  if test -f $bundle; then
    source $bundle
  else
    source $bundle/${bundle##*/}.zsh
  fi
done
