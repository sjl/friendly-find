#!/usr/bin/env bash

cd tests
cram *.t | pygmentize -l diff
