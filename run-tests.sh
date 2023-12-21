#!/bin/sh

export INDEX_NAME=mediacloud_test
export ESHOSTS=http://localhost:9200

if [ `which pytest` = "" ]; then
    # XXX maybe just create venv, activate, and install requirements?
    echo 'cannot find pytest; need to active venv, and/or run "pip -r requirements-dev.txt"?' 1>&2
    exit 1
fi

if ! curl --silent $ESHOSTS | grep -q tagline; then
    echo cannot find elasticsearch at $ESHOSTS: see docs/testing.md 1>&2
    exit 2
fi

if ! curl --silent $ESHOSTS/_cat/indices | grep -q $INDEX_NAME; then
    # XXX maybe just run it here?
    echo 'need to run "python -m test.create_fixtures"' 1>&2
    exit 3
fi

pytest test
