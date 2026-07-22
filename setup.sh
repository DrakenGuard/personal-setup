#/usr/bin/env bash

set -euo pipefail # exit immediately if something in the process fails

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
	echo "This script only works on linux."
	exit 1
fi

if [[ -z ${1+x} ]]; then
	read -p "This script installs vim-plug for vim and neovim and sets the theme for both to gruvbox. Are you sure you want to continue? (y/N) " prompt < /dev/tty

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

main() {
	printf "\nConfiguring for vim\n"
	if [[ -f /usr/bin/vim ]]; then
		install_vimplug vim
		set_theme_gruvbox vim
	else
		echo "Vim not installed / Vim not found in '/usr/bin/vim'. Skipping config for vim..."
	fi

	printf "\nConfiguring for nvim\n"
	if [[ -f /usr/bin/nvim ]]; then
		install_vimplug neovim
		set_theme_gruvbox neovim
	else
		echo "Neovim not installed / Neovim not found in '/usr/bin/nvim'. Skipping config for neovim..."
	fi

	printf "\nSetup complete!\n"
}

main
