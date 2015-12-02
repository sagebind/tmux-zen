function tmux.notify -d "Displays a message in the tmux status bar"
  if not count $argv > /dev/null
    cat ^/dev/null | read -l line
    set argv[1] "$line"
  end

  tmux display-message "$argv[1]"
end
