#!/bin/bash

xmllint --format $1 | sponge $1
