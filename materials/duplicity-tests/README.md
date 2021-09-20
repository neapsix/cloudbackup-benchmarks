### Client-Specific Setup for Backup Tests with `duplicity`
>Prerequisites: a GnuPG2 key pair already imported (optional, see note below),
>a b2 application key and ID, and a b2 bucket.

1. Install `duplicity` using your package manager or another method.
2. In the `run-duplicity-test` and `run-duplicity-restore-test` files, enter the following information instead of the placeholder text:
  * B2 application Key ID
  * B2 application Key
  * B2 bucket name
  * The last eight characters of your GPG key ID. You can see this ID with `$ gpg --list-keys`.
  * The passphrase of your GPG key

>Note: You can optionally have duplicity create a GnuPG key on the first run.
>This script assumes you've already created one and that you're using the same
>key for signing and encryption. Don't use your real GPG key for a test, and
>be careful with your private key and passphrase if you use a similar setup in
>production.
