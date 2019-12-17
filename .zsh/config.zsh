source_if_exist() {
  test -s $1 && source $1
}
source_bundles() {
  for bundle; do
    test -d $bundle || continue

    # load the bundle itself
    source_if_exist $bundle/${bundle##*/}.plugin.zsh ||
    source_if_exist $bundle/${bundle##*/}.zsh ||
    source_if_exist $bundle/init.zsh

    # load bundle configuration
    source_if_exist $bundle.zsh ||:
  done
}
source_configs() {
  for config; do
    source $config
  done
}

source_bundles ~/.zsh/bundle/before/*
source_configs ~/.zsh/config/**/*sh
source_bundles ~/.zsh/bundle/after/*
