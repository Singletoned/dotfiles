alias reload!='. ~/.zshrc'
alias mirror="wget -rkmpxE --adjust-extension --random-wait"
alias docker-clean='docker rm -v $(docker ps -a -q -f status=exited) && docker rmi $(docker images -f "dangling=true" -q)'
alias create-project='mkvirtualenv ${PWD##*/} && setvirtualenvproject && pip install -r requirements.txt'
