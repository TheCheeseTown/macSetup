#!/usr/bin/env bash

scriptpath="$PWD"
cd "$scriptpath"

#!/bin/bash

printf 'Do you want to install XCode? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	pprintf "Installing XCode\n"
    xcode-select --install
fi

printf 'Do you want to change macos behaviour? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    printf "Setting up macos\n"
    source macos.sh --no-restart
fi


printf 'Do you want to install Homebrew? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
cd "$scriptpath"
    printf "Installing homebrew\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

printf 'Do you want to install Homebrew packages? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    printf "Installing homebrew packages\n"
    packagestoinstall=()
    packagestoinstall=("${packagestoinstall[@]}" "neovim")
    packagestoinstall=("${packagestoinstall[@]}" "tmux")
    packagestoinstall=("${packagestoinstall[@]}" "git")
    packagestoinstall=("${packagestoinstall[@]}" "tree-sitter")
    packagestoinstall=("${packagestoinstall[@]}" "lazygit")
    packagestoinstall=("${packagestoinstall[@]}" "python@3")
    packagestoinstall=("${packagestoinstall[@]}" "iperf")
    packagestoinstall=("${packagestoinstall[@]}" "gcc")
    packagestoinstall=("${packagestoinstall[@]}" "font-jetbrains-mono-nerd-font")
    packagestoinstall=("${packagestoinstall[@]}" "mas")
    packagestoinstall=("${packagestoinstall[@]}" "dockutil")

    for package in "${packagestoinstall[@]}";
        do brew install $package
    done
fi

printf 'Do you want to install Homebrew casks? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    printf "Installing homebrew casks\n"
    appstoinstall=()
    appstoinstall=("${appstoinstall[@]}" "alacritty")
    appstoinstall=("${appstoinstall[@]}" "visual-studio-code")
    for app in "${appstoinstall[@]}";
        do brew install --cask $app
    done
fi

printf 'Do you want to install AstroNVIM config for neovim? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
printf "Installing astro NVIM\n"

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
fi

printf 'Do you want to install tmux config? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    cd "$scriptpath"
    printf "Installing tmux config file\n"
    cp .tmux.conf ~/.tmux.conf
fi

printf 'Do you want to install alacritty config? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    printf "Installing Alactritty config file\n" 
    cp alacritty.toml ~/.alacritty.toml
fi

printf 'Do you want to install macos apps from app Store? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    printf "Installing MacOS applications\n"
    macosappstoinstall=()
    macosappstoinstall=("${macosappstoinstall[@]}" "441258766") #Magnet
    for macapp in "${macosappstoinstall[@]}";
        do mas install $macapp
    done
fi


printf 'Do you want to Change the dock? (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    printf "Removing dock apps\n"
    dockappstoremove=()
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/TV.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Podcasts.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Safari.app")
    #dockappstoremove=("${dockappstoremove[@]}" /Applications/"Mail.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/FaceTime.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Messages.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Maps.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Photos.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Contacts.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Calendar.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Reminders.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Notes.app")
    #dockappstoremove=("${dockappstoremove[@]}" "/Applications/Music.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/News.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/'App Store'.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Pages.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Numbers.app")
    dockappstoremove=("${dockappstoremove[@]}" "/Applications/Keynote.app")
    #dockappstoremove=("${dockappstoremove[@]}" "/Applications/Freeform.app")
    for docapp in "${dockappstoremove[@]}";
        do dockutil -r $docapp
    done

    printf "Adding dock apps\n"
    dockappstoadd=()
    dockappstoadd=("${dockappstoadd[@]}" "/Applications/Alacritty.app")
    dockappstoadd=("${dockappstoadd[@]}" "/Applications/Visual Studio Code.app")
    for docapp in "${dockappstoadd[@]}";
        do dockutil -a $docapp
    done
fi

printf "Finished setting up the mac!"
