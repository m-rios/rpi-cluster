#!/bin/bash
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if which pv > /dev/null ; then
  export PV=''
fi
