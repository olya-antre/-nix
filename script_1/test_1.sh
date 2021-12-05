#!/bin/bash

files=(file_1.txt, file2, -file_3.html)

for file in "${files[@]}"
do
	bash add_sfx.sh -d -- 000 "$file"
done
