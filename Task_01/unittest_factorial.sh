#!/bin/bash

#checks for 3 args
if [ "$#" -ne 3 ]; then
	echo "$0 <program> <argument> <expected>"
	exit 1
fi

program="$1"
argument="$2"
expected="$3"

#checks that the prgram exists
if [ ! -f "$program" ]; then
	echo "$program does not exist"
	exit 1
fi

#runs the program
actual=$("$program" "$argument")

if [ "$actual" == "$expected" ]; then
	echo "PASS"
else
	echo -e "FAIL\nExpected: $expected\nGot: $actual"
fi
