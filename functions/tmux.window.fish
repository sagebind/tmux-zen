function tmux.window -d "Prints the index of the current tmux window"
  tmux display-message -p '#I'
end
