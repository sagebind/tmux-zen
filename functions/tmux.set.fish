function tmux.set -d "Sets a variable for all tmux windows"
  set -q argv[2]
    or set argv[2] ""

  # Set the variable for the current window as well as all future windows.
  set -g $argv[1] $argv[2]
  tmux setenv -g -t $__tmux_session_name $argv[1] $argv[2]
end
