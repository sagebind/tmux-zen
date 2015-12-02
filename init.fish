# Initialize the current fish session and connect to the tmux session.
function init --on-event init_tmux-zen
  if not available tmux
    echo "Install tmux first to achieve zen."
    return 1
  end

  set -q __tmux_session_name
    or set -U __tmux_session_name local

  # Connect to the TMUX session if it exists, or create it if it doesn't.
  if not set -q TMUX
    if tmux has-session -t $__tmux_session_name
      exec tmux new-session -t $__tmux_session_name \; set destroy-unattached on \; new-window
    else
      exec tmux new-session -s $__tmux_session_name
    end
  else
    # Initialize the session if we didn't already.
    if not set -q __tmux_is_initialized
      # Set a global variable to make sure we only get called once per session.
      tmux.set __tmux_is_initialized

      # Emit an init event.
      emit tmux.init
    end
  end
end
