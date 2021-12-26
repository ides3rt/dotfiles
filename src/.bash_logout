#!/usr/bin/env bash

if ((UID)); then
	((SSH_AGENT_PID)) && eval `ssh-agent -k`
	killall xcape
fi &>/dev/null
