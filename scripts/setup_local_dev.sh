#!/bin/bash

# detect whether default shell is bash, zsh, or fish and active mise
activate_mise() {
    echo "Activating mise..."
    if [[ $SHELL == *"bash"* ]]; then
        echo 'Activating mise for bash'
        echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
    elif [[ $SHELL == *"zsh"* ]]; then
        echo 'Activating mise for zsh'
        echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
    elif [[ $SHELL == *"fish"* ]]; then
        echo 'Activating mise for fish'
        echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish
    else
        echo "Shell not supported. Please set up manually."
        exit 1
    fi
    echo "mise activated"
}

# detect whether mise is installed
if [ -z "$(which mise)" ]; then
    echo "mise is not installed. Installing mise..."
    curl https://mise.run | sh
fi

activate_mise

echo "Enabling experimental mise features..."
mise settings set experimental true

# install dependencies with mise
echo "Installing dependencies..."
mise trust
mise install

# mise run migrate
# mise run seed

cat << EOF

Setup is complete. You may need to source mise to use the installed dependencies.
bash:   source ~/.bashrc
zsh:    source ~/.zshrc
fish:   source ~/.config/fish/config.fish

EOF