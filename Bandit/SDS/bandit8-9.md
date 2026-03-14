Level 8-9
one_command|other_command
The command in the left gives its output to the command on the right as input.
cmd>thingname  ---> the output of cmd is saved in the thingname
cmd>>thingname ---> the output is appended at the end of thing not deleted previously stored data

cmd<thingname ---> cmd acts on thingname
Eg: Read it etc.
    wc -l < barry.txt > myoutput
    the command wc - l counted lines in barry.txt and stored them in myoutput

sort filename   used to sort file alphabetically by default
    -r  reverse order
    -n  sort numerically
    -u  removes duplicate
uniq filename   removes duplicates and keep only one copy
    -u shows lines that appear exactly once
    -d shows lines that are duplicatws

used sort data.txt | uniq -u


Pass
4CKMh1JI91bUIZZPXDqGanal4xvAg0JM