if [ ! -f ~/.bash_profile ]; then
  echo "Creating ~/.bash_profile"
  touch ~/.bash_profile
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
  echo "No id_rsa.pub found. This is used to authenticate with Github/Gitlab. Let's generate a new key now."
  read -p "Enter your email address on Github: " github_email
  ssh-keygen -t rsa -b 4096 -C "$github_email"

  echo ""
  echo "Copy the text below and upload to https://github.com/settings/ssh/new:"
  echo ""
  cat ~/.ssh/id_rsa.pub
  echo ""
  read -n 1 -s -r -p "Press any key to continue"
fi

if [ -d ~/.dotfiles ]
then
  LAST_DIR=$(pwd)
  echo "Directory ~/.dotfiles found, rebasing..."
  cd ~/.dotfiles
  git pull --rebase origin main
  cd $LAST_DIR
else
  echo "Cloning git@github.com:guivahl/dotfiles.git into ~/.dotfiles"
  git clone git@github.com:guivahl/dotfiles.git ~/.dotfiles
fi

export DOTFILES=~/.dotfiles

echo ""
echo "Installing homebrew..."
brew_setup

echo ""
echo "Installing MacOS software... "
source $DOTFILES/macos
install_macos

