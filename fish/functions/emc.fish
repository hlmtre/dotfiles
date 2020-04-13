function emc
	emacsclient -n --socket-name=/tmp/emacs(id -u)/server $argv
end
