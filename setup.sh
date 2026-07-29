#/usr/bin/env bash

set -euo pipefail # exit immediately if something in the process fails

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
	echo "This script only works on linux."
	exit 1
fi

if [[ -z ${1+x} ]]; then
	read -p "This script installs vim-plug for vim and neovim and sets the theme for both to gruvbox. Are you sure you want to continue? (y/N) " prompt < /dev/tty

	echo ""

	if [[ ! $prompt == "y" && ! $prompt == "Y" ]]; then
		echo "Exiting program"
		exit 0
	fi
elif [[ $1 != -*y* && $1 != "--yes" ]]; then
	echo "Exiting program"
	exit 1
fi

: '
The first argument for install_vimplug must be the type of vim (e.g. vim or neovim).
'
install_vimplug() {
	vimplug="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

	case $1 in
		vim)
			vimplug_path="$HOME/.vim/autoload/plug.vim"
			;;
		neovim)
			vimplug_path="$HOME/.local/share/nvim/site/autoload/plug.vim"
			;;
	esac

	if [[ ! -f $vimplug_path ]]; then
		echo "Installing vim-plug for $1"
		curl -fLo $vimplug_path --create-dirs \
			$vimplug
	else
		echo "Vim-plug for $1 exists. Continuing..."
	fi
}

: '
The first argument for set_theme_gruvbox must be the type of vim (e.g. vim or neovim).
'
set_theme_gruvbox() {
	case $1 in
		vim)
			config=$HOME/.vimrc
			curl "https://raw.githubusercontent.com/DrakenGuard/personal-setup/refs/heads/main/vim-config.vim" > $config
			vim -Nu $config -es +'PlugInstall --sync' +qall
			;;
		neovim)
			mkdir -p $HOME/.config/nvim
			config=$HOME/.config/nvim/init.vim
			curl "https://raw.githubusercontent.com/DrakenGuard/personal-setup/refs/heads/main/neovim-config.vim" > $config
			nvim --headless -u $config +PlugInstall +qall
			;;
	esac
}

set_custom_html() {
	case $1 in
		vim)
			echo "Setting custom html configurations currently not supported in vim"
			;;
		neovim)
			read -p "Setting up custom html configurations on neovim (turns 4 spaces into 2 spaces). Do you want to continue? (Y/n) " prompt < /dev/tty
			if [[ $prompt == "n" || $prompt == "N" ]]; then
				echo "Cancelling neovim html configurations setup..."
				return 0
			fi
			mkdir -p $HOME/.config/nvim/ftplugin
			config=$HOME/.config/nvim/ftplugin/html.vim
			curl "https://raw.githubusercontent.com/DrakenGuard/personal-setup/refs/heads/main/html.vim" > $config
			echo "Html configurations setup on neovim is finished!"
			;;
	esac
}

main() {
	read -p "Would you like for this script to configure vim? Note that any personal configurations you've done will be overridden by this script. (y/N) " prompt < /dev/tty

	if [[ -f /usr/bin/vim && ($prompt == "y" || $prompt == "Y") ]]; then
		printf "Configuring for vim...\n"
		install_vimplug vim
		set_theme_gruvbox vim
		set_custom_html vim
	else
		printf "Vim not installed / Vim not found in '/usr/bin/vim' / Cancelled. Skipping config for vim...\n\n"
	fi

	read -p "Would you like for this script to configure neovim? Note that any personal configurations you've done will be overridden by this script. (y/N) " prompt < /dev/tty

	if [[ -f /usr/bin/nvim && ($prompt == "y" || $prompt == "Y") ]]; then
		printf "Configuring for nvim...\n"
		install_vimplug neovim
		set_theme_gruvbox neovim
		set_custom_html neovim
	else
		printf "Neovim not installed / Neovim not found in '/usr/bin/nvim' / Cancelled. Skipping config for neovim...\n\n"
	fi

	printf "\nSetup complete!\n"
}

main
