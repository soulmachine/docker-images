A command line client analog to the Google Authenticator App.


## How to run

    docker run -it --rm -v $(pwd):/root/.authenticator soulmachine/authenticator --help


## Add an account

Add a Gmail,

    docker run -it --rm -v $(pwd):/root/.authenticator soulmachine/authenticator add Google:example@gmail.com

The passphase is used to encrypt the database file, which stores all accounts and secrets.

If you want to setup both your Android App and cli client, it is important that you capture the QR code and then click the link for the secret string secret code. If you capture the secret and click “back” to get the QR code then a new secret will be generated and the new QR won’t match the previously captured secret string.


## Backup the database file

The database file is located at `/root/.authenticator`, you should copy it multiple places such as Dropbox, Google Drive, etc.


## Generate codes

    docker run -it --rm -v $(pwd):/root/.authenticator soulmachine/authenticator generate

## Delete an account

    docker run -it --rm -v $(pwd):/root/.authenticator soulmachine/authenticator delete Google:example@gmail.com
