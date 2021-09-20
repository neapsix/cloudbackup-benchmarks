## Client-Specific Setup for Backup Tests with `rclone`
>Prerequisites: a b2 application key and ID, and a b2 bucket.

1. Install `rclone` using your package manager or another method.
2. Set up `rclone` and authenticate with your b2 bucket by running `$ rclone config`.
2. In the `run-rclone-test` and `run-rclone-restore-test` files, enter the B2 bucket name instead of the placeholder text.
