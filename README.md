# Network-and-remote-server-automation-and-scripting
Creating an automated shell script that can boot up and execute the same commands across multiple remote servers and VMs eliminates human error and promotes effectiveness.
DESCRIPTION:
- we are going to reset our vagrant configuration file via Vim; we will be adding the IP addresses and network settings we wish to use for our automated script before running a vagrant up to boot our new servers
01.
  ![01](https://github.com/kelubia/Network-and-remote-server-automation-and-scripting/assets/98921903/cd0f0d50-461b-4598-b167-e9c0926250ab)


List out our servers and the SSH options we will be using to time out our servers when experiencing connection errors. We are setting it to 2 seconds.
We want sudoers to be able to run this script independently without any restriction in functionality or need for special privileges.
- we will create a usage statement that will be built into a function.
- store the return code or exit value into the SSH code and send error codes to standard error.
- since we are executing on various systems, we don't want one failed server error to affect the other running codes. Easily remove failed server without affecting other running servers,
- make sure we have /etc/host entries for servers.
-02
  ![02](https://github.com/kelubia/Network-and-remote-server-automation-and-scripting/assets/98921903/85312e21-fa37-40ea-9f9b-36037ad379ea)


- ping the servers,
- 03
- ![03](https://github.com/kelubia/Network-and-remote-server-automation-and-scripting/assets/98921903/21502cc7-638d-47da-bfcf-c3b6a0ba9857)


configure SSH Authentication, key-value pair using SSH-keygen and copy to servers
04
![04](https://github.com/kelubia/Network-and-remote-server-automation-and-scripting/assets/98921903/ef0f6f4f-f67c-42b7-9463-a4f1506bb333)

![4b](https://github.com/kelubia/Network-and-remote-server-automation-and-scripting/assets/98921903/b169ac53-3d8b-4a54-b653-fe9e9caca0d4)



- Run the script and check that each command is executed as planned.
05
![05](https://github.com/kelubia/Network-and-remote-server-automation-and-scripting/assets/98921903/5abe7f6f-3ce5-4dea-8e21-1906fdf33a53)
