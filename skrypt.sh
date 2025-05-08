#!/bin/bash

# To exit the script if error occurs (will happen if sudo is not used)
set -e

users_to_create=100
sleep_time=2

# $1 is a positional argument that represents how many users we want to create.
# If provided we will create the specified number of users instead of 100.
if [[ $# -gt 0 ]]; then
	users_to_create=$1
fi

#Preparing a file to save list of added usernames.
> added_users

# Each loop iteration is a seperate request to the API. This could be improved by
# requesting more results with ?results=n and iterating over the data received
for ((i=1; i<=$users_to_create; i++));
do
	data=$(curl "https://randomuser.me/api?nat=us&inc=name,login" -sS)
	first_name=$(echo $data | jq -r '.results[0].name.first')
	last_name=$(echo $data | jq -r '.results[0].name.last')
	username=$(echo $data | jq -r '.results[0].login.username')
	echo "Adding the following user:"
	echo "Full name: ${first_name} ${last_name}"
	echo "login: ${username}"
	echo "--------------------------"
	echo "${username}" >> added_users

	# The created user does not have a password.
	# This could be improved by setting up a password,
	# but it wasn't specified in the requirements.
	useradd -m -s /bin/bash $username
	chfn -f "${first_name} ${last_name}" $username

	if (( i % 5 == 0 && i < users_to_create )); then
		echo "Waiting ${sleep_time} seconds"
		echo "--------------------------"
		sleep $sleep_time
	fi
done

