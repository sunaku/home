# load bundles
for dir in ~/.zsh/bundle/*; do
  source $dir/${dir##*/}.zsh
done

# delegate configuration to files in config/
for file in ~/.zsh/config/**/*.zsh; do
  source $file
done
