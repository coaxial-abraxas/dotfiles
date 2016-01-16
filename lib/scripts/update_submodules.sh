#!/usr/bin/env bash

# Updates submodules and brings them up to date
git submodule update --init --recursive
git submodule update --init --remote
