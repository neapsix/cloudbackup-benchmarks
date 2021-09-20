### Client-Specific Setup for Backup Tests with `restic`
>Prerequisites: a GnuPG2 key pair already imported (optional, see note below),
>a b2 application key and ID, and a b2 bucket.

1. Download and prepare the `restic` binary:
```sh
$ wget https://github.com/restic/restic/releases/download/vX.X.X/restic_X.X.X_freebsd_amd64.bz2
$ bzip2 -d restic_X.X.X_freebsd_amd64.bz2
$ chmod u+x restic_X.X.X_freebsd_amd64.bz2
$ mv restic_0.12.0_freebsd_amd64 restic
```
2. Initialize restic, set an encryption password, authenticate it with b2, point it to your b2 bucket:
```sh
$ export B2_ACCOUNT_ID="YOUR_B2_APPLICATION_ID"
$ export B2_ACCOUNT_KEY="YOUR_B2_APPLICATION_KEY"
$ ./restic -r b2:neapspace-restic-test init
```
3. Create a file that the script can read enter your restic password. You might want to put it in the same directory as the restic binary, such as `/home/you/restic-pw`.
>This is a plain-text file, so don't reuse any real passwords.

4. In the `run-restic-test` and `run-restic-restore-test` files, enter the following information instead of the placeholder text:
  * B2 application key ID
  * B2 application key
  * B2 bucket name (the restic repository is b2:your-bucket-name)
  * The path to the file with your restic password
  * The path to your restic binary
