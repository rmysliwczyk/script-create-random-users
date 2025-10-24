# Adding random Linux users from randomuser.me/api

## WARNING!
This script will create users without setting passwords for them. Please keep that in mind, so that you won't compromise your system with unprotected users. Just in case, remember that users can be deleted with `userdel -r username`

## Dependecies
To run this script you must install `jq`, as it is used for retrieving relevant data from the API json response. It is present in all popular package managers. For installing on Debian-based distributions you can run:
```bash
sudo apt install jq
```

## Running the script
Because the script needs to create users on the system, it will need super user access, therefore it must be ran with `sudo`, like so:
```bash
sudo chmod +x skrypt.sh
sudo ./skrypt.sh
```

## Optional arguments
By default, the script will create 100 users. You can select a custom number of users to be created by providing a positional argument like so:
```bash
# Create 20 users
sudo ./skrypt.sh 20
```
