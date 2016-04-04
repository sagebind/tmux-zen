<div align="center">
  <a href="http://github.com/oh-my-fish/oh-my-fish">
  <img width=90px  src="https://cloud.githubusercontent.com/assets/8317250/8510172/f006f0a4-230f-11e5-98b6-5c2e3c87088f.png">
  </a>
</div>
<br>

# tmux zen
Plugin for [Oh My Fish][omf] to tap into the zen power of [tmux].


## Install
You will first need to install tmux. The best way is usually with your operating system's package manager. Otherwise, you can download and compile tmux yourself:

```fish
$ wget https://github.com/tmux/tmux/releases/download/2.0/tmux-2.0.tar.gz
$ tar xcf tmux-2.0.tar.gz; and cd tmux-2.0
$ ./configure; and make
$ sudo make install
```

Now you can install tmux zen using [Oh My Fish][omf]:

```fish
$ omf install tmux-zen
```

That's it! Prepare yourself for an epic journey to ultimate terminal zen.


## The path to zen
Tmux is a terminal multiplexer geared toward developers and admins who regulary make use of the terminal. Fish (and the Oh My Fish framework) is a friendly interactive shell that is an intuitive alternative to the old and confusing syntax of bash-like shells.

In tmux zen, tmux allows us to break the concept of terminal sessions out of desktop windows and into a central location. This location is the *session*, which will contain all of our terminal windows that will ever exist. Any time you open a terminal app, you will be presented with a *portal* that allows you to view and access the session. When you desire to create a new shell prompt, you do so by creating a new *window*. A window is similar to a window in a graphical deskop, except that it lives in our zen session.

This journey assumes basic knowledge on both tmux and fish.

### Managing windows
First, we need to open a portal in order to access our session. We can do this by simply opening a terminal and running `fish`. A portal will be opened, and the terminal will now be connected to the session. By default, the session will be created if it did not already exist. Opening a portal will also create us a new empty window in the session with a fish shell prompt waiting for you. You can use this window like any other terminal window.

When we are using an open portal, we can interact with our session windows just like normal tmux windows and panes. To create a new window, you can use `Prefix+c`. The view will switch to a new window, while keeping our old window still open. If we run `exit`, only the current window will be closed.

### More on portals
In tmux zen, portals are cheap. If you close your terminal app, you might normally expect your shell session to be forcefully closed. When you close a portal however, all of your windows in the session remain in existence. To access them again, simply open up another portal.

The workflow becomes even closer to zen when using multiple portals. Go ahead and try to open two, three, or more portals. You will notice that all of the portals provide a view into our same session each time, but each can view a different window or the same window. This allows us to select whatever windows we need to access simultaneously by using multiple portals and switching to the desired window in each.

### Preparing our workspace
It can be very helpful to run some commands each time the session is created for the first time. This could be startup scripts, or scripts that open certain programs in certain windows. We can set these commands by creating a fish function that listens for the `zen.init` [event]. Tmux zen will trigger this event once, when the session is first created. For example, here's a script that will open Vim in its own window:

```fish
function my-zen-init --on-event zen.init
    zen tmux new-window vim
end
```

Add this to your `config.fish` (or in some other setup script) and next time we start our session, a Vim window will be created for us.


## Configuration
Tmux zen has a few configuration options that you can customize:

- `session-name`: The name to use for the shared tmux session.
- `tmux-bin`: Specify a specific tmux binary to execute tmux commands with.
- `events.init`: A Fish script to also run on the `zen.init` event.

See `zen config --help` for help on how to modify these settings.


## Need some guidance?
This journey isn't meant to be a solo experience. Feel free to ask me [@coderstephen](http://twitter.com/coderstephen) or any other tmux guru for guidance.


## License
[MIT][mit] © [coderstephen][author] et [al][contributors]


[mit]:            http://opensource.org/licenses/MIT
[author]:         http://github.com/coderstephen
[contributors]:   https://github.com/coderstephen/tmux-zen/graphs/contributors
[omf]:            https://github.com/oh-my-fish/oh-my-fish
[event]:          http://fishshell.com/docs/current/index.html#event
[tmux]:           https://tmux.github.io
[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
