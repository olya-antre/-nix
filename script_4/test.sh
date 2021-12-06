#!/bin/bash

echo "Test_1: using help"
bash ins_sfx.sh -h -- olylya

echo -e "\nTest_2: using [-d]"
bash ins_sfx.sh -d -- olya dir "*book.txt"

echo -e "\nTest_3: using invalid option"
bash ins_sfx.sh -t -- olya dir "*.html"

echo -e "\nTest_4: using wrong name of directory"
bash ins_sfx.sh -d -- olya dir

echo -e "\nTest_5: using [-v]"
bash ins_sfx.sh -v -- olya dir "*.html"

