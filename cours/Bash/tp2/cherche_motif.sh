#!/bin/bash

CHEMIN="$1"
CHAINE="$2"

ls "$CHEMIN" 2>/dev/null | grep "$CHAINE" 2>/dev/null
