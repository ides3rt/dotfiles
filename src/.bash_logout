#!/usr/bin/env bash

# If running restricted or non interactive, don't do anything
{ [[ $- != *i* || $SHELL != *bash* ]] || shopt -q restricted_shell ;} && return

if ((UID)); then
	((SSH_AGENT_PID)) && eval `ssh-agent -k`
fi &>/dev/null
