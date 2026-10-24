# 2.1.1
cd ~
mkdir -p test
cd test
touch file
ls -l file
# 2.1.2
chmod 000 file
# 2.1.3
chmod u+w file
echo "Hello" > file
cat file
# 2.1.4
chmod g+r file
cat file
# 2.1.5
chmod u+r file
cat file
# 2.1.6
mkdir dir
cd dir
echo "Lol" > new_file
ls
ls -l
# 2.1.7
cd ..
chmod -x dir
ls -ld dir
cat dir/new_file
rm dir/new_file
(chmod u+x dir)
# 2.1.8
chown root file
# 2.1.9
umask 077
touch new_secret_file
ls -l new_secret_file
# 2.1.10
umask 000
touch public_file
ls -l public_file
(umask 022)
# 2.1.11
sudo su -
chown root /home/lisa/test/file
ls -l /home/lisa/test/file
chmod 400 /home/lisa/test/file
ls -l /home/lisa/test/file
exit
# 2.1.12
(from lisa)
cat file
sudo chmod 440 file
cat file

# 2.2.1
id
whoami
# 2.2.2
grep "^lisa:" /etc/passwd
grep "^lisa:" /etc/group
# 2.2.3
sudo groupadd labgroup
grep "^labgroup:" /etc/group
# 2.2.4
sudo useradd -m -s /bin/bash labuser
grep "^labuser:" /etc/passwd
# 2.2.5
sudo passwd labuser
su - labuser (12345)
whoami
id
pwd
exit
# 2.2.6
su - labuser
touch my_file
ls -l my_file
exit
# 2.2.7
sudo usermod -aG labgroup labuser
labuser labgroup
# 2.2.8
sudo useradd -m -s /bin/bash labuser2
sudo passwd labuser2 (12345)
sudo usermod -aG labgroup labuser2
# 2.2.9
sudo mkdir /tmp/lab_shared
sudo chgrp labgroup /tmp/lab_shared
sudo chmod 770 /tmp/lab_shared
# 2.2.10
su - labuser
touch /tmp/lab_shared/from_labuser.txt
su - labuser2
cat /tmp/lab_shared/from_labuser.txt
echo "Modified" >> /tmp/lab_shared/from_labuser.txt
rm /tmp/lab_shared/from_labuser.txt
exit
# 2.2.11
sudo chmod g+s /tmp/lab_shared/
ls -ld /tmp/lab_shared/
su - labuser
touch /tmp/lab_shared/user1.txt
ls -l /tmp/lab_shared/user1.txt
exit
su - labuser2
touch /tmp/lab_shared/user2.txt
ls -l /tmp/lab_shared/user2.txt
exit
# 2.2.12
sudo mkdir /tmp/lab_public
sudo chmod 1777 /tmp/lab_public/
ls -ld /tmp/lab_public/
su - labuser
touch /tmp/lab_public/file_labuser.txt
exit
su - labuser2
touch /tmp/lab_public/file_labuser2.txt
exit
su - labuser
rm /tmp/lab_public/file_labuser2.txt
exit
# 2.2.13
sudo usermod -L labuser
su - labuser
sudo usermod -U labuser
su - labuser
whoami
exit
# 2.2.14
sudo chage -l labuser
sudo chage -d 0 labuser
su - labuser
# 2.2.15
sudo usermod -s /bin/sh labuser
grep "^labuser:" /etc/passwd
sudo usermod -s /bin/bash labuser
# 2.2.16
sudo userdel labuser2
grep "^labuser2:" /etc/passwd
ls -ld /home/labuser2
ls -l /home/labuser2
# 2.2.17
cat /etc/passwd | head -20
grep -E "^(daemon|bin|sys):" /etc/passwd
# 2.2.18
grep -E "^(UID_MIN|UID_MAX|SYS_UID_MIN|SYS_UID_MAX)" /etc/login.defs
# 2.2.19
sudo useradd -m testuser
sudo useradd -r testsystem
grep -E "^(testuser|testsystem):" /etc/passwd
# 2.2.20
sudo userdel testsystem
sudo useradd -r -m testsystem
ls -ld /home/testsystem
# 2.2.21
grep -E "(nologin|false)$" /etc/passwd | head -5
which nologin
which false
# 2.2.22
sudo usermod -s /usr/sbin/nologin testuser
su - testuser
sudo -u testuser id
# 2.2.23
(sudo cp /etc/login.defs /etc/login.defs.bak)
sudo usermod -s /bin/false testuser
2.2.24
sudo usermod -s /bin/bash testuser
su - testuser
exit
# 2.2.25
sudo usermod -s /bin/ls testuser
su - testuser
sudo usermod -s /bin/bash testuser
# 2.2.26
sudo groupadd -r testsystemgroup
sudo groupadd testgroup
getent group testsystemgroup
getent group testgroup
# 2.2.27
grep -E "^(GID_MIN|GID_MAX|SYS_GID_MIN|SYS_GID_MAX)" /etc/login.defs
# 2.2.28
sudo useradd -r -g testsystemgroup -M -s /usr/sbin/nologin serviceuser
grep "^serviceuser:" /etc/passwd
# 2.2.29
su - testuser
sudo id
# 2.2.30
sudo visudo
testuser ALL=(ALL) /usr/bin/id
su - testuser
sudo id
sudo ls 
exit
# 2.2.31
sudo visudo
testuser ALL=(ALL) /usr/bin/id, /bin/ls
# 2.2.32
sudo groupadd testadmins
sudo usermod -aG testadmins testuser
sudo visudo
%testadmins ALL=(ALL) /usr/bin/id
sudo gpasswd -d testuser testadmins
su - testuser
exit
# 2.2.33
grep -E "^(UID_MIN|UID_MAX|GID_MIN|GID_MAX|SYS_UID_MIN|SYS_UID_MAX|CREATE_HOME|USERGROUPS_ENAB|UMASK|SHELL)" /etc/login.defs
# 2.2.34
sudo nano /etc/login.defs
### 2.2.34
sudo nano /etc/login.defs
UID_MIN 1000 -> 5000
sudo useradd -m configuser1
id configuser1
sudo userdel -r configuser1
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.35
sudo nano /etc/login.defs
SYS_UID_MIN 101 -> 200
SYS_UID_MAX 999 -> 250
grep SYS_UID /etc/login.defs
sudo useradd -r sysconfig1
sudo useradd -r sysconfig2
sudo useradd -r sysconfig3
id sysconfig1
id sysconfig2
id sysconfig3
sudo userdel sysconfig1 sysconfig2 sysconfig3
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.36
sudo nano /etc/login.defs
GID_MIN 1000 -> 5000
sudo groupadd configgroup1
getent group configgroup1
sudo groupdel configgroup1
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.37
sudo nano /etc/login.defs
SYS_GID_MIN 101 -> 300
SYS_GID_MAX 999 -> 350
sudo groupadd -r sysgroup1
sudo groupadd -r sysgroup2
getent group sysgroup1
getent group sysgroup2
sudo groupdel sysgroup1
sudo groupdel sysgroup2
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.38
sudo nano /etc/login.defs
CREATE_HOME yes (добавить строку)
sudo useradd homeuser1
ls -ld /home/homeuser1
sudo useradd homeuser2
ls -ld /home/homeuser2
sudo userdel -r homeuser1
sudo userdel homeuser2
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.39
sudo useradd -r syshome1
ls -ld /home/syshome1
sudo useradd -r -m syshome2
ls -ld /home/syshome2
sudo userdel -r syshome2
sudo userdel syshome1
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.40
sudo nano /etc/login.defs
HOME_MODE 0750 -> 0700
sudo useradd -m umasktest1
ls -ld /home/umasktest1
HOME_MODE 0700 -> 0750
sudo useradd -m umasktest2
ls -ld /home/umasktest2
sudo userdel umasktest1
sudo userdel umasktest2
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.41
sudo nano /etc/login.defs
USERGROUPS_ENAB yes
sudo useradd ugtest1
getent group ugtest1
sudo nano /etc/login.defs
USERGROUPS_ENAB no
sudo useradd ugtest2
getent group ugtest2
sudo userdel ugtest1
sudo userdel ugtest2
sudo cp /etc/login.defs.bak /etc/login.defs
# 2.2.42
sudo nano /etc/default/useradd
SHELL=/bin/sh -> SHELL=/bin/bash
sudo useradd defaultuser1
grep "^defaultuser1:" /etc/passwd
sudo userdel defaultuser1
sudo nano /etc/default/useradd
SHELL=/bin/sh
# 2.2.43
sudo nano /etc/default/useradd
HOME=/users
sudo mkdir /users
sudo chmod 755 /users
sudo useradd -m defaultuser2
grep "^defaultuser2:" /etc/passwd
ls -ld /users/defaultuser2
sudo userdel -r defaultuser2
sudo rmdir /users
sudo nano /etc/default/useradd
sudo cp /etc/login.defs.bak /etc/login.defs