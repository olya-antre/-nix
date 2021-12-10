#!/bin/bash

#test_1
echo "Test_1: using help"
bash topsize_new.sh --help -- Olya

#test_2
echo -e "\nTest_2: using invalid option"
bash topsize_new.sh -l -10 

#test_3
echo -e "\nTest_3: using [-s] [-h] [-N] and current directory"
bash topsize_new.sh -s 100 -h -5

#test_4
echo -e "\nTest_4: using only [-h]"
bash topsize_new.sh -h 

#test_5
echo -e "\nTest_4: print first 2 files"
bash topsize_new.sh -2


