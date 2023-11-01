# git_project
A training project as part of Udemy course

Step 1: Created a centOS VM through VMWare
Step 2: Download git in VM
Step 3: Created a remote repository in Github
Step 4: clone the repository in VM
Step 5: Create new branch in git
Step 6: Add ssh keys in ssh-agent as authentication method 
	1. ssh-keygen -t ed25519 -C "your_email@example.com"
	2. eval "$(ssh-agent -s)"
	3. ssh-add ~/.ssh/id_ed25519
Step 7: Add public key in github account
Step 8: Test the ssh connection
	1. ssh -T git@github.com
Step 9: At time of pushing the content. git will ask for username and password
	1. Username: email-address
	2. Password: PAT token
