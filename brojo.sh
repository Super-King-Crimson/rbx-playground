#!/usr/bin/env bash
# Put any environment variables in brojo.conf
# For example: ROJO_OUT_PATH='/mnt/c/Users/skc/Desktop/out.rbxlx'
if [ -f brojo.conf ]; then
	source brojo.conf
fi

if [ -z $ROJO_OUT_PATH ]; then
	ROJO_OUT_PATH='out.rbxlx'
fi

BROJO_LOCK='brojo.lock'

if [ ! -f "$ROJO_OUT_PATH" ]; then
	rojo build -o "$ROJO_OUT_PATH"
	echo "Successfully built $(realpath $ROJO_OUT_PATH)"
else
	echo "WARNING: Skipped build path; $(realpath $ROJO_OUT_PATH) already exists"
fi


if [ -f $BROJO_LOCK ]; then
	echo 'WARNING: Stopped after build step; brojo lockfile is present'
	exit
fi

SOURCEMAP_PID=
SERVE_PID=

cleanup() {
	kill $SOURCEMAP_PID $SERVE_PID &> /dev/null
	rm -rf $BROJO_LOCK &>/dev/null
	exit ${1:-1}
}

rojo sourcemap --watch default.project.json -o sourcemap.json &
SOURCEMAP_PID=$!
printf "rojo sourcemap PID: $SOURCEMAP_PID\n\n"

rojo serve &
SERVE_PID=$!
printf "rojo serve PID: $SERVE_PID\n\n"

echo $SOURCEMAP_PID > $BROJO_LOCK
echo $SERVE_PID >> $BROJO_LOCK

trap cleanup EXIT INT HUP TERM

while sleep 0.5; do
	if ! kill -0 "$SOURCEMAP_PID" &>/dev/null; then
		echo "ERROR: rojo sourcemap failed" >&2
		cleanup
	fi

	if ! kill -0 "$SERVE_PID" &>/dev/null; then
		echo "ERROR: rojo serve failed" >&2
		cleanup
	fi
done
