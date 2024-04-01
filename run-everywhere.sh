#!/bin/bash

#A list of servers, one per line.
SERVER_LIST='/vagrant/servers'

#SSH time out options, for servers
SSH_OPTIONS='-o ConnectionTimeout=2'

usage() {
 
 #Display the usage and exit.
  echo "Usage: ${0} [-nsv] [-f FILE] COMMAND" >&2
  echo 'Executes COMMAND as a single command on every server.' >&2
  echo " -f FILE Use FILE for the list of servers. Default: ${SERVER_LIST}." >&2
  echo ' -n	Dry run mode.Display the COMMAND that would have been executed then exit.' >&2
  echo ' -s	Execute the COMMAND using sudo on the remote server.' >&2
  echo ' -v	verbose mode. Displays the server name before executing COMMAND.' >&2
  exit 1

}
#Make sure the script doesnt restrict functionality to superuser privilages.
if [[ "${UID}" -eq 0 ]]
then
 echo 'Do not execute this script as root. Use the -s option instead.' >&2
 usage
fi

#Parse the optons.
while getopts f:nsv OPTION
do
  case ${OPTION} in
    f) SERVER_LIST="${OPTARG}" ;;
    n) DRY_RUN='true' ;;
    s) SUDO='sudo' ;;
    v) VERBOSE='true' ;;
    ?) usage ;;
  esac
done

#Remove the options hile leaving the arguments.

shift "$(( OPTIND - 1 ))"

#If an arguement isnt supplied by the user... assist them.
if [[ "${#}" -lt 1 ]]
then 
  usage
fi

#Anything that remains on the command line is to be treated as a single command.
COMMAND="${@}"

#Make sure the SERVER_LIST file exists
if [[ ! -e "${SERVER_LIST}" ]] 
then
 echo "cannot open server list file ${SERVER_LIST}." >&2
 exit 1
fi

EXIT_STATUS='0'

# Loop through the SERVER_LIST

for SERVER in $(cat ${SERVER_LIST})
do
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${SERVER}"
  fi

SSH_COMMAND="ssh ${SSH_OPTIONS} ${SERVER} ${SUDO} ${COMMAND}"

#If its a dry run, dont execute anything, just echo it.
if [[ "${DRY_RUN}" = 'true' ]]
then
 echo "DRY RUN: ${SSH_COMMAND}"
else
 ${SSH_COMMAND}
 SSH_EXIT_STATUS="${?}"

 #Capture any non-zero exit status from the SSH_COMMND and report to the user.

if [[ "${SSH_EXIT_STATUS}" -ne 0 ]]
then 
  EXIT_STATUS="${SSH_EXIT_STATUS}"
  echo "Excution on ${SERVER} FAILED." >&2
 fi
fi
done

exit ${EXIT_STATUS}
