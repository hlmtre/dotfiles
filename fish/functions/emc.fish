function emc
	emacsclient -n --socket-name=/tmp/emacs(id -u)/primary $argv
end
