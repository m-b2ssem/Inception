#!/usr/bin/env bash

if [ ! -d "/home/bmahdi/data" ]; then
	mkdir -p /home/bmahdi/data
fi

if [ ! -d "/home/bmahdi/data/wp" ]; then
	mkdir -p /home/bmahdi/data/wp
fi

if [ ! -d "/home/bmahdi/data/db" ]; then
	mkdir -p /home/bmahdi/data/db
fi

if [ ! -d "/home/bmahdi/data/redis" ]; then
	mkdir -p /home/bmahdi/data/redis
fi