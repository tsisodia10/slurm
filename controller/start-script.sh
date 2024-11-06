#!/bin/bash


/usr/sbin/munged --num-threads=10 &
sleep 2

/usr/sbin/slurmctld -Dvv
