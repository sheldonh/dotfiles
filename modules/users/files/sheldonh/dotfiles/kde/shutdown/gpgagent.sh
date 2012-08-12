#!/bin/sh

# GPG_AGENT_INFO=/home/sheldonh/.gnupg/S.gpg-agent:17019:1

if [ -n "$GPG_AGENT_INFO" ]; then
	pid=${GPG_AGENT_INFO#*:}
	pid=${pid%:*}
	kill $pid
fi
