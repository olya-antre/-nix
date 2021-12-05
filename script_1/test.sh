#!/bin/bash

files=(file_1.txt file2 -file3.html, file)

#test_1
echo "Test_1: using [-d] "
bash add_sfx.sh -d -- 000 "${files[0]}"

#test_2
echo -e "\nTest_2: using invalid option"
bash add_sfx.sh -d -l -- 000 "${files[1]}"

#test_3
echo -e "\nTest_3: using help"
bash add_sfx.sh -h -- 000 "${files[2]}"

#test_4
echo -e "\nTest_4: using [-v] with wrong file's name"
bash add_sfx.sh -v -- 000 "${files[3]}"
