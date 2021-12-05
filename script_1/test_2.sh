#!/bin/bash

files=(-file_3.html)

for file in "${files[@]}"
do
	bash add_sfx.sh -h -- 000 "$file"
done
