# delegate configuration
for config in ~/.zsh/config/**/*sh; do
  source $config
done

# load plugin bundles
source_if_exist() { test -s $1 && source $1 }
for bundle in ~/.zsh/bundle/*; do
  # load the bundle itself
  source_if_exist $bundle/${bundle##*/}.plugin.zsh ||
  source_if_exist $bundle/${bundle##*/}.zsh ||
  source_if_exist $bundle/init.zsh

  # load bundle configuration
  source_if_exist $bundle.zsh ||:
done
