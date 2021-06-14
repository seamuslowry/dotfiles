log_file=~/install_packages_log.txt

sudo apt -y install gh
if type -p gh > /dev/null; then
    echo "gh Installed" >> $log_file
else
    echo "gh FAILED TO INSTALL!!!" >> $log_file
fi

echo -e "\n====== Install Summary ======\n"
cat $log_file
rm $log_file