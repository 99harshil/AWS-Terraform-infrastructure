A training project as part of Udemy course


************ SSH into macOS for below steps ****************

Step 1: Created a centOS VM through VMWare

*********** Download GIT in server ************************

Step 1: Created a remote repository in Github
Step 2: clone the repository in VM
Step 3: Create new branch in git
Step 4: Add ssh keys in ssh-agent as authentication method 
	1. ssh-keygen -t ed25519 -C "your_email@example.com"
	2. eval "$(ssh-agent -s)"
	3. ssh-add ~/.ssh/id_ed25519
Step 5: Add public key in github account
Step 6: Test the ssh connection
	1. ssh -T git@github.com
Step 7: At time of pushing the content. git will ask for username and password
	1. Username: email-address
	2. Password: PAT token

************** Download Jenkins in Server *****************

Step 1: sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
Step 2: sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
Step 3: sudo yum upgrade
Step 4: sudo yum install fontconfig java-17-openjdk
Step 5: sudo yum install jenkins
Step 6: sudo systemctl daemon-reload
Step 7: sudo systemctl enable jenkins
Step 8: sudo systemctl start jenkins
Step 9: sudo systemctl status jenkins
Step 10: firewall-cmd --add-port=8080/tcp --permanent
Step 11: firewall-cmd --reload
Step 12: firewall-cmd --list-all
Step 13: go to website (http://ip:8080/)
Step 14: Copy password from location "/var/lib/jenkins/secrets/initialAdminPassword" and complete the setup

**************** Download Terraform in Server *****************

Step 1: sudo yum install -y yum-utils
Step 2: sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
Step 3: sudo yum -y install terraform

***************** Download AWS CLI in Server ******************

Step 1: curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
Step 2: unzip awscliv2.zip
Step 3: sudo ./aws/install
Step 4: ls -l /usr/local/bin/aws
Step 5: aws --version

***************** Configure AWS in server  ******************

Step 1: aws configure
Step 2: Populate AWS access key and AWS secret key with default region
Step 3: Check AWS account number from below command
	1. aws sts get-caller-identity --query "Account" --output text

***************** Download Ansible in Server ******************

Step 1: Check Python in server
Step 2: Check pip module is downloaded in server
Step 3: python3 -m pip install --user ansible
Step 4: ansible --version
Step 5: ansible-community --version
Step 6: python3 -m pip install --user argcomplete
Step 7: activate-global-python-argcomplete --user

***************** Download Credstash in Server ***************
Step 1: Install python dependencies
	1. sudo yum install gcc libffi-devel python-devel openssl-devel
Step 2: pip install credstash
Step 3: credstash setup

