#!/bin/bash

# Set up autocompletion for custom aliases

function _git_nuke() { _git_branch; }
function _git_sm() { _git_submodule; }
function _git_squash_merge_rebase { _git_branch; }

__git_complete gi __git_main
__git_complete gti __git_main
