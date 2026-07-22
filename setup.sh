#/usr/bin/env bash

printf "This script installs vim-plug for vim and neovim and sets the theme for both to gruvbox. Are you sure you want to continue? (y/N) "

read prompt

if [[ ! $prompt == "y" && ! $prompt == "Y" ]]; then
	echo "Exiting program"
	exit 0
fi

if [[ -f /usr/bin/vim ]]; then
	if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
		echo "Installing vim-plug for vim"
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		echo "Vim-plug for vim exists. Continuing..."
	fi
	curl "https://raw.githubusercontent.com/DrakenGuard/personal-setup/refs/heads/main/vim-config.vim" > ~/.vimrc
	vim -es +PlugInstall +qall
else
	echo "Vim not installed. Skipping config for vim..."
fi

if [[ -f /usr/bin/nvim ]]; then
	if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
		echo "Installing vim-plug for neovim"
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		echo "Vim-plug for neovim exists. Continuing..."
	fi
	echo "Configuring neovim..."
	curl "https://raw.githubusercontent.com/DrakenGuard/personal-setup/refs/heads/main/neovim-config.vim" > ~/.config/nvim/init.vim
	nvim --headless +PlugInstall +qall
else
	echo "Neovim not installed. Skipping config for neovim..."
fi

