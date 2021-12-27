#!/usr/bin/env bash

if ((UID)); then
	eval `ssh-agent -k`
fi &>/dev/null
