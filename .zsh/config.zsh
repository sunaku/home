source ~/.pathrc

# delegate configuration
for file in ~/.zsh/config/**/*.zsh; do
  source $file
done

# load plugin bundles
for bundle in ~/.zsh/bundle/*; do
  test -d $bundle && bundle=$bundle/${bundle##*/}.zsh
  test -f $bundle && source $bundle
done
