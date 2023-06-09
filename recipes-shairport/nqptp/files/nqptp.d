#! /bin/sh
### BEGIN INIT INFO
# Provides:          nqptp
# Required-Start:    $all
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Not Quite PTP
# Description:       nqptp is a daemon that monitors timing data from any PTP clocks it sees on ports 319 and 320
### END INIT INFO

# Author: Balthazar Deliers
#
# Do NOT "set -e"

# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Not Quite PTP Service"
NAME=nqptp
DAEMON=/usr/bin/$NAME

# We don't use the DAEMON_ARGS variable here because some of the identifiers may have spaces in them, and so are
# impossible to pass as arguments.

# Instead, we add the arguments directly to the relevant line in the do_start() function below
PIDFILE=/var/run/$NAME/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# LSB log_* functions
. /etc/init.d/functions

#
# Function that starts the daemon/service
#
do_start()
{
	# Return
	#   0 if daemon has been started
	#   1 if PID directory didn't exist and couldn't be created with appropriate permission
	#   2 if daemon was already running
	#   3 if daemon could not be started
        [ -e /var/run/nqptp ] || ( mkdir -p /var/run/nqptp ) || return 1
	start-stop-daemon --start --quiet --background --pidfile $PIDFILE --exec $DAEMON --test > /dev/null || return 2

	# This script is set to start running after all other services have started.
	# However, if you find that Shairport Sync is still being started before what it needs is ready,
	# uncomment the next line to get the script to wait for three seconds before attempting to start Shairport Sync.
	# sleep 3

	# Settings from the configuration file (/etc/nqptp.conf by default)
	start-stop-daemon --start --quiet --background --pidfile $PIDFILE --exec $DAEMON -- -d || return 3
}

#
# Function that stops the daemon/service
#
do_stop()
{
	# Return
	#   0 if daemon has been stopped
	#   1 if daemon was already stopped
	#   2 if daemon could not be stopped
	#   other if a failure occurred
	start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE --name $NAME
	RETVAL="$?"
	[ "$RETVAL" = 2 ] && return 2
	# Wait for children to finish too if this is a daemon that forks
	# and if the daemon is only ever run from this initscript.
	# If the above conditions are not satisfied then add some other code
	# that waits for the process to drop all resources that could be
	# needed by services started subsequently.  A last resort is to
	# sleep for some time.
	start-stop-daemon --stop --quiet --oknodo --retry=0/30/KILL/5 --exec $DAEMON
	[ "$?" = 2 ] && return 2
	# Many daemons don't delete their pidfiles when they exit.
	rm -f $PIDFILE
	return "$RETVAL"
}

#
# Function that sends a SIGHUP to the daemon/service
#
do_reload() {
	#
	# If the daemon can reload its configuration without
	# restarting (for example, when it is sent a SIGHUP),
	# then implement that here.
	#
	start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME
	return 0
}

case "$1" in
  start)
	do_start
	;;
  stop)
	do_stop
	;;
  status)
	status "$DAEMON"
	;;
  restart|force-reload)
	#
	# If the "reload" option is implemented then remove the
	# 'force-reload' alias
	#
	do_stop
	;;
  *)
	#echo "Usage: $SCRIPTNAME {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

: