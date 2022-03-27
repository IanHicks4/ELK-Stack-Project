#!/bin/bash



awk -v time="$2" -v ampm="$3" '($0 ~ ("^"time)) && (tolower($2) == tolower(ampm)) {print $1, $2, $5, $6}' "$1"* > Dealers_working_during_losses.txt



