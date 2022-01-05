# soft-serve

Create a new SSH key with ED25519:

    ssh-keygen -t ed25519 ~/.ssh/id_ed25519

Add new host to `~/.ssh/config`:

    Host localhost
      Identity ~/.ssh/id_ed25519
      Port 23231
      User root

Start the container with the environment variable `SOFT_SERVE_INITIAL_ADMIN_KEY` using the content of `~/.ssh/id_ed25519.pub` as value.

Finally, connect with SSH to view the TUI:

    ssh localhost
