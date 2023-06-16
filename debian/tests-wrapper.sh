#!/bin/sh
# Keep this in sync with
# https://gitlab.gnome.org/GNOME/gnome-remote-desktop/-/blob/master/.gitlab-ci/run-tests.sh
set -ex

trap '{ kill -9 $pipewire_pids 2>/dev/null || true; }' EXIT

export HOME="$(mktemp -d --tmpdir grd-home-XXXXXX)"

pipewire &
pipewire_pids=$!
sleep 1

wireplumber &
pipewire_pids="$pipewire_pids $!"
sleep 1

gsettings set org.gnome.desktop.remote-desktop.vnc enable true

$@
