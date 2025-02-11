#!/usr/bin/env bash

if [ !-d "/home/bassem/data" ]; then
	mkdir -p /home/bassem/data
fi

if [ ! -d "/home/bassem/data/wp" ]; then
	mkdir -p /home/bassem/data/wp
fi

if [ ! -d "/home/bassem/data/db" ]; then
	mkdir -p /home/bassem/data/db
fi

if [ ! -d "/home/bassem/data/redis" ]; then
	mkdir -p /home/bassem/data/redis
fi