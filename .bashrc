######################################
# Ethan Link's .bashrc/.bash_profile #
######################################


# Set the bash prompt color, and set the prompt character to Greater than (>)
# This webpage was incredibly helpful: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# \e - escape character
# [35m - light magenta
# [1m - Bold
# \u - Print the current username
# [0m - Clear all prior formatting
# [92m - light green
# \w - Print current working directory
# $(parse_git_branch) - Use the above function to get the current git branch
export PS1="\[\e[35m\]\[\e[1m\]\u\[\e[0m\] @ \[\e[92m\]\w\[\e[0m\]\[\e[93m\]\$(parse_git_branch)\[\e[0m\] > "

# Print welcome message for myself, using cowsay
RANDOM_NUMBER=$(($RANDOM % 3))

if ((RANDOM_NUMBER == 0)); then
    cowsay "Welcome to your bash terminal, ${USER} :)"
elif ((RANDOM_NUMBER == 1)); then
    cowsay -f tux "Welcome to your bash terminal, ${USER} :)"
else
    cowsay -f stegosaurus "Welcome to your bash terminal, ${USER} :)"
fi
echo "=================================="


# Can never have enough color
git config --global color.ui true


# aliasing
alias ls="ls -a --color"
alias gs="git status"
alias cd..="cd .."
alias shrug='echo "¯\_(ツ)_/¯"' #Just for fun


# Add History across Git Bash sessions
export PROMPT_COMMAND='history -a'


##################
# Bash Functions #
##################

# Display the current git branch in the prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Function specifically for working with multi-repo workspaces (Like GM HWIO)
# Usage: "loop git switch main"
# Alternate: Run command from base (DepArch) dir: 
# for dir in *; do (cd "$dir" && echo "$dir" && git switch main); done
loop(){
     for dir in *
     do
          (cd "$dir"
          echo "$dir"
          "$@")
     done 
}

# Function specifically for working with multi-repo workspaces (GM HWIO Specific)
# Prints the branch name for every repo inside a directory
print_branch(){
     for dir in *
          do
          (cd "$dir"
          echo "$dir"
          git rev-parse --abbrev-ref HEAD)
     done
}

# Function specifically for working with multi-repo workspaces (GM HWIO Specific)
# 'prune' alias does not work with loop() function above
# This function is to handle pruning all remote repos 
prune_remote(){
     for dir in *
     do
          (cd "$dir"
          echo "$dir"
          git remote update origin --prune)
     done 
}


