#!/usr/bin/env bash

# Quick start-stop-daemon example, derived from Debian /etc/init.d/ssh
set -e

# Must be a valid filename
NAME=twitch_bot
PIDFILE=/var/run/$NAME.pid
#This is the command to be run, give the full pathname
DAEMON="/usr/bin/python3 path_to_bot/bot.py"

case "$1" in
  start)
        echo -n "Starting daemon: "$NAME
    start-stop-daemon --start --quiet --background --chuid twitch_bot --group twitch_bot --chdir path_to_bot --make-pidfile --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
        echo "."
    ;;
  stop)
        echo -n "Stopping daemon: "$NAME
    start-stop-daemon --stop --quiet --oknodo --remove-pidfile --pidfile $PIDFILE
        echo "."
    ;;
  restart)
        echo -n "Restarting daemon: "$NAME
    start-stop-daemon --stop --quiet --oknodo --retry 30 --remove-pidfile --pidfile $PIDFILE
    start-stop-daemon --start --quiet --background --chuid twitch_bot --group twitch_bot --chdir path_to_bot --make-pidfile --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
    echo "."
    ;;
esac

exit 0
