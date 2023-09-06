#!/usr/bin/env bash
set -ex
FORCE=$1

DEFAULT_ARGS="--system-title-bar"
ARGS=${APP_ARGS:-$DEFAULT_ARGS}


maximus &
if ( [ -z "$DISABLE_CUSTOM_STARTUP" ] ||  [ -n "$FORCE" ] ) ; then
    if [ -f /tmp/custom_startup.lck ] ; then
        echo "custom_startup already running!"
        exit 1
    fi
    touch /tmp/custom_startup.lck
    while true
    do
        if ! pgrep -x DesktopEditors >> /dev/null
        then
            /usr/bin/desktop_ready
            /usr/bin/filter_ready
            set +e
            onlyoffice-desktopeditors $ARGS
            set -e
        fi
        sleep 1
    done
    rm /tmp/custom_startup.lck
fi