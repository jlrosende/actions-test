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

mkdir -p /github/home/cache

ls -la /github/home/cache

touch "/github/home/cache/$(date +"%Y-%m-%d-%H-%M-%S")"

ls -la /github/home/cache