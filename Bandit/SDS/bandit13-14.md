Level 13-14

It gave me the private key for next level.
I copied the key and logged out
I thought of using the key directly in the ssh command
but that failed so i made a file names ssh.private in my local device and stored the code there and wrote the filename as such
ssh -i file_namehavingprivatekey username@websitename -p 2220

but it said this type of file needs special security
so i used 

chmod ugo file_name  permission changing command
    u   owner
    g   group
    o   others
    4/r read
    2/w write
    1/x execute
    there sum denote the permission given three digit first for u then g then o
then the command worked I went to the path where key was stored and recovered it

Pass
MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS