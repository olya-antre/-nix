#!/bin/bash

#test_1
echo "Test_1: using help"
bash topsize.sh --help -- Olya

#test_2
echo -e "\nTest_2: using invalid option"
bash topsize.sh -l -10 

#test_3
echo -e "\nTest_3: using [-s] [-h] [-N] and current directory"
bash topsize.sh -s 100 -h -5 -- .

#test_4
echo -e "\nTest_4: using only [-h]"
bash topsize.sh -h -- .

#test_5
echo -e "\nTest_5: using [-s] without minsize"
bash topsize.sh -s -- .

