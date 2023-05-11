if ! [ $( docker ps -a | grep postgres_app | wc -l ) -gt 0 ]; then
sudo sed -i 's/^#/ /g' ansible/upgrade.yml
fi

