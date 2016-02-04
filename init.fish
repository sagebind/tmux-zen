# Initialize the current fish session and connect to the tmux session.
function init --on-event init_tmux-zen
  set TMUXBIN tmux
  if not available tmux
    echo "Install tmux first to achieve zen."
    return 1
  end

  # if the user has byobu installed, use that instead
	if available byobu-tmux
		set TMUXBIN byobu-tmux
  end

  # If we're running in a superuser shell, do nothing.
  if test $USER = root
    return 0
  end

  set -q __tmux_session_name
    or set -U __tmux_session_name local

  # Connect to the TMUX session if it exists, or create it if it doesn't.
  if not set -q TMUX
    if tmux has-session -t $__tmux_session_name
     eval exec $TMUXBIN new-session -t $__tmux_session_name \; set destroy-unattached on \; new-window
    else
      eval exec $TMUXBIN new-session -s $__tmux_session_name
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
