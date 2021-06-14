#!/bin/bash

gsfg() {
  git_command="git $@ || true"
  git submodule foreach "$git_command"
}