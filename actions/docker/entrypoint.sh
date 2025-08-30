#!/bin/bash

getent passwd $USER

echo "/github"
ls -la /github
echo "--------------------------------"

echo "/github/workspace"
ls -la /github/workspace
echo "--------------------------------"

echo "/github/home"
ls -la /github/home
echo "--------------------------------"

echo "/github/file_commands"
ls -la /github/file_commands
echo "--------------------------------"

mkdir -p cache
touch "/github/home/cache/$(date)"

ls /github/home/cache