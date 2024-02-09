#!/bin/bash

if [ $(quota -w | tail -n 1 | head -n 1 | cut -d " " -f 2) \< 5291456 ] 
then
	echo "Tout est ok"
else
	echo "Pas assez d'espace !"
fi
