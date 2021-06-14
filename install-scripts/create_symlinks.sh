log_file=~/install_symlinks_log.txt

echo "$(basename $(pwd))"

# are we in right directory?
if [ $(basename $(pwd)) != "dotfiles" ]; then
  echo "doesn't look like you're in dotfiles/"
  exit 1
fi

configuration_directory="../.home-configuration/*"
scripts_directory="../.scripts/*"

home_scripts_directory="$HOME/.scripts/"

# symlink all the home directory files
for f in $configuration_directory; do
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

# create the scripts directory
mkdir -p $home_scripts_directory
# symlink all the scripts files
for f in $scripts_directory; do
  existing_file="$home_scripts_directory/$(basename $f)"

  # if the file exists; delete it
  if [ -f $existing_file ]; then
    echo "Deleting old version of $existing_file" >> $log_file
    rm -rf $existing_file
  fi

  echo "Symlinking script $f to $existing_file"  >> $log_file
  # make the symlink
  ln -sf $f $existing_file
done

echo -e "\n====== Symlink Summary ======\n"
cat $log_file
rm $log_file