log_file=~/install_symlinks_log.txt

# are we in right directory?
if [ $(basename $(pwd)) != "dotfiles" ]; then
  echo "doesn't look like you're in dotfiles/"
  exit 1
fi

configuration_directory_files="$(pwd)/.home-configuration/.*"

scripts_directory="$(pwd)/.scripts"
home_scripts_directory="$HOME/.scripts"

# symlink all the home directory files
for f in $configuration_directory_files; do
  if [ -d $f ]; then
      continue
  fi

  existing_file="${HOME}/$(basename $f)"

  # if the file exists; delete it
  if [ -f $existing_file ]; then
    echo "Deleting old version of $existing_file" >> $log_file
    rm -rf $existing_file
  fi

  echo "Symlinking configuration $f to $existing_file"  >> $log_file
  # make the symlink
  ln -sf $f $existing_file
done

echo -e '\n'

echo "Removing old script directiory at $home_scripts_directory"
rm $home_scripts_directory
echo "Symlinking script directory $scripts_directory to $home_scripts_directory"  >> $log_file
ln -sf $scripts_directory $home_scripts_directory


echo -e "\n====== Symlink Summary ======\n"
cat $log_file
rm $log_file