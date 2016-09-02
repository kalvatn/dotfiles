#!/bin/bash

set -e

source "$(dirname "$(readlink -f "$0")")/.functions"

if needs_install ansible; then
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt-get update
  sudo apt-get install ansible
fi

exit 0

if needs_install virtualbox dkms virtualbox-dkms; then
	info "adding virtualbox repository"
	sudo apt-add-repository -y "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
	info "updating packages (quiet)"
	curl -s -L "https://www.virtualbox.org/download/oracle_vbox_2016.asc" | sudo apt-key add
	sudo apt-get update -qq
	apt_install virtualbox dkms virtualbox-dkms
fi

if needs_install vagrant; then
	VAGRANT_DEB_FILE="/tmp/vagrant.deb"
	deb_file_url="$(curl -sL "https://www.vagrantup.com/downloads.html" | xmllint --html --xpath "//a[contains(@href, 'x86_64.deb')]/@href" - 2> /dev/null | cut -d '"' -f2)"

	info "downloading '$deb_file_url' -> '$VAGRANT_DEB_FILE'"
	curl -s -L "$deb_file_url" -o "$VAGRANT_DEB_FILE"
	info "installing '$VAGRANT_DEB_FILE'"
	sudo dpkg -i "$VAGRANT_DEB_FILE"
fi
