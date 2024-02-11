# description
bash and zsh completion for artelad cli

https://github.com/artela-network/artela

# features
parse artelad cli output to auto generate the completion (if the artelad cli evolves, the completion will auto update itself)

# install and use

for bash

    wget https://raw.githubusercontent.com/thibault-ketterer/artlead-completion/main/completion-artelad.bash
	mv completion_artelad.bash ~/
	echo "source completion_artelad.bash" >> ~/.bashrc


for zsh (in progress..., only 2 subcommands for now)

    wget https://raw.githubusercontent.com/thibault-ketterer/artlead-completion/main/completion-artelad.zsh
	mv completion-artelad.zsh ~/
	echo "source completion-artelad.zsh" >> ~/.zshrc

# Demo
![Demo asciinema artelad completion](demo.gif "demo asciinema artelad completion")
