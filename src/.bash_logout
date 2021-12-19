#!/usr/bin/env bash

if ((UID)); then
	((SSH_AGENT_PID)) && eval `ssh-agent -k`
fi &>/dev/null
