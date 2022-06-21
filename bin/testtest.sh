echo "all tests, one test should fail"
bin/test.sh
echo "one test, should fail, and show output"
bin/test.sh 0
echo "one test, will pass and print a message indicating that"
bin/test.sh 1
echo "four tests, one fails"
bin/test.sh 0 3 5 7
echo "three tests, all pass"
bin/test.sh 4 6 15
