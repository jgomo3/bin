#!/bin/bash

if [ "$#" -eq 0 ]; then
  CF=" -c "
fi

(emacsclient -n $CF $@ || emacs $@ > /dev/null) &
