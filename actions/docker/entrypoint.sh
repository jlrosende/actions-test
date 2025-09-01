#!/bin/bash

getent passwd $USER
echo "--------------------------------"

env
echo "--------------------------------"

echo "/github/home"
ls -la /github/home
echo "--------------------------------"

uv tool install basic-memory
echo "--------------------------------"

echo "# My Note\n\nThis is a test note" | uvx basic-memory tool write-note \
  --title "Test Note" --folder "notes"
echo "--------------------------------"

mkdir -p /github/home/cache

ls -la /github/home/cache
echo "--------------------------------"

touch "/github/home/cache/$(date +"%Y-%m-%d-%H-%M-%S")"

ls -la /github/home/cache
echo "--------------------------------"

echo "/github/home"
ls -la /github/home
echo "--------------------------------"

echo "/github/home/basic-memory"
ls -la /github/home/basic-memory
echo "--------------------------------"


echo "/github/home/.basic-memory"
ls -la /github/home/.basic-memory
echo "--------------------------------"

cat /github/home/.basic-memory/config.json
