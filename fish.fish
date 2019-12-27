#!/usr/local/bin/fish

mkdir -p "$HOME/etc/ssh"

function ssh-procure-launch-agent
    eval (ssh-agent -c -a ~/etc/ssh/ssh-agent-socket)
    ssh-add
end

# if SSH_AGENT_PID is unset...
if ! set -q SSH_AGENT_PID
  if test -e ~/etc/ssh/ssh-agent-socket # ... but the socket already exists...
    set -x SSH_AGENT_PID (ps -fC ssh-agent |grep 'etc/ssh/ssh-agent-socket' |sed -r 's/^\S+\s+(\S+).*$/\1/')
    if string match -rq '^[0-9]+$' SSH_AGENT_PID
      # in this case the agent has already been launched and we are just attaching to it.
      ##++  It should check that this pid is actually active & belongs to an ssh instance
      set -x SSH_AUTH_SOCK ~/etc/ssh/ssh-agent-socket
    else
      # in this case there is no agent running, so the socket file is left over from a graceless agent termination.
      rm ~/etc/ssh/ssh-agent-socket
      ssh-procure-launch-agent
    end
  else
    ssh-procure-launch-agent
  end
end
