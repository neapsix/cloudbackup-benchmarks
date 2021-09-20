## Client-Specific Setup for Backup Tests with `b2 sync`
>Prerequisites: Python 3, pip, a b2 application key and ID, and a b2 bucket

1. Install the `b2` utility from pip: `pip install --upgrade b2`
2. Authenticate with b2 using your application key: `b2 authorize-account <applicationKeyID> <applicationKey>`
3. Edit the `run-b2-sync-test` and `run-b2-sync-restore-test` files and enter the name of your b2 bucket instead of the placeholder text.
