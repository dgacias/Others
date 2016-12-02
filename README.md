Comparador.ps1

Powershell script to compare 2 folders to seek checksum differences on their files. I use it to upload files to remote sites, re-download them and check if they are still the same file.

Master files are compared against copies files to search for differences in files, if there are differences, it throws an error on the screen and the log.

Prerequisites:
You need to create 2 folders in the same folder as comparador.ps1 named "master" and "copies".

Note: Only compares what is in the master folder, if the copies folder has more files they will be ignored.
