export TERM="xterm-256color"
export PYTHONPATH=/usr/lib/py-libs:/usr/lib/py-dev:/usr/lib/py-dbg:/usr/lib
export DJANGO_SETTINGS_MODULE=proj.settings
export NODE_PATH=$(npm root -g)

alias createtags='git ls-files "*.[ch]" | grep -v -E "^linux-" > cscope.files && cscope -bk'
alias createtagskernel='git ls-files "*.[ch]" > cscope.files && cscope -bk'

find_fosfeature() {
    git grep $1 -- cooked/platform_info | cut -c 22- | sed 's/_feature/ /g' | awk '{print "  * " $1}' | uniq
}

alias fosfeature=find_fosfeature

make_fosconfig() {
    ./Configure -m ${1-FGT_100D} -d y -l all -v "$(git rev-parse --abbrev-ref HEAD)"
}
alias fosconfig=make_fosconfig

gui_grep() {
    git grep -i "$1" -- migadmin fortiweb
}

alias gg=gui_grep

git_workdir() {
    cd ~/git
    echo "Creating working directory $1"
    /usr/share/doc/git/contrib/workdir/git-new-workdir fos.gerrit $1
    cd $1
    git fetch
    echo "Checking out branch $1 from ${2-$1}."
    git checkout origin/${2-$1} -b $1
}

alias gwork=git_workdir

#export NVM_DIR="/home/jthompson/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# Node/NPM
if [ -f "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    source $NVM_DIR/nvm.sh
    export NODE_PATH=$(npm root -g)
fi
