#!/bin/bash

user_name_1=Olya
user_name_2=root

file_name=users.txt

#test_1
echo -e "\nTest_1: with original username and file passwd. "
bash userhome.sh

#test_2
echo -e "\nTest_2: using help. "
bash userhome.sh -h

#test_3
echo -e "\nTest_3: using the username Olya and a file with the list of users users.txt. "
bash userhome.sh -f -- Olya users.txt

#test_4
echo -e "\nTest_4: using the username root and orginal file passwd. "
bash userhome.sh -- root 

#test_5
echo -e "\nTest_5: using the username Olya and original file passwd. "
bash userhome.sh -- Olya

#test_6
echo -e "\nTest_6: using invalid option."
bash userhome.sh -g -- Olya users.txt

#test_7
echo -e "\nTest_7: using wrong file with the list of users."
bash userhome.sh -f -- Olya user

