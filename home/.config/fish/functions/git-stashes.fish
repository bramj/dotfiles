function git-stashes --description 'Page through all stashes with their diffs'
    git stash list | awk -F: '{ print "\n\n\n\n"; print $0; print "\n\n"; system("git -c color.ui=always stash show -p " $1); }' | less -R
end
