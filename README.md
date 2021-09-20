# cloudbackup-benchmarks
Procedure and scripts for benchmarking some popular cloud backup utilities for
use with Backblaze B2.

This repo is a companion to a series of articles on [neap.space](https://neap.space):
* [Deep Dive: Cloud Backup for Slow Connections, Part I](https://neap.space/2021/04/deep-dive-cloud-backup-for-slow-connections-part-i/)
* [Deep Dive: Cloud Backup for Slow Connections, Part II](https://neap.space/2021/04/deep-dive-cloud-backup-for-slow-connections-part-ii/)
* Part III coming soon

The results of each test are collected in the `data/` directory. For a more
legible version, refer to the `graphsheet/` directory and to the accompanying
articles.

The following sections, as well as the other README files in the materials
directories describe how to re-run the tests and collect your own results.

## Run Backup Tests for Each Client and Test Case
>Prerequisites: a test machine with a dataset containing some files mounted
>as `/tank` and a remote target, such as a b2 bucket, ready to go.

To run the backup tests for a certain backup client, complete the following tasks:
* Copy the directory containing materials for one of the clients to the test machine.
* Perform client-specific setup, such as installing the client, initializing a backup repository, and setting up encryption keys. This setup is described in README files in the materials directory.
* Perform the test procedure described below. After doing the file operations for each test case, run the backup script in the working directory provided for that test case.

To compare multiple backup clients, repeat these tasks for each backup client.
For example, you might set up four virtual machines, and repeat the tasks for a
different backup client in each virtual machine.

The test procedure is:
1. Perform an initial backup of a dataset.
1. Add some files and perform an incremental backup.
1. Modify some files and perform an incremental backup.
1. Touch just one file and perform an incremental backup.
1. Remove some files and perform an incremental backup.
1. Delete everything and restore from the backup.

Here's an example of how you would run a backup test for `restic`:
1. Copy the restic materials to your test machine:
  ```sh
  $ rsync -hav ./restic-tests user@testmachine:/home/user/
  ```
2. Perform client-specific setup. For example:
  ```sh
  $ wget https://github.com/restic/restic/releases/download/v0.12.1/restic_0.12.1_freebsd_amd64.bz2
  $ bzip2 -d restic_0.12.1_freebsd_amd64.bz2
  $ ./restic -r b2:name-of-your-b2-bucket init
  $ vi ./restic-pw # write the restic passowrd in a file the script can read
  $ vi ~/restic-tests/run-restic-test # specify b2 and restic credentials
  $ vi ~/restic-tests/run-restic-restore-test # enter b2 and restic credentials
  ```
  >Note: if you're using ZFS or btrfs, it's helpful to create a filesystem
  >snapshot before performing each test. For example, run
  >`# zfs snapshot -r tank@initial` before the first test.
3. Perform the first test. To capture the output of `time` and to avoid
having to babysit these tests, I recommend running tests overnight in a logged
and detached `screen` or `tmux` session.
  ```sh
  $ screen -X
  $ cd ~/restic-tests/0-initial
  $ ../run-restic-test
  ```
4. For each test case after the first, modify the files and run the script
again:
  ```sh
  $ rsync -hav user@remote:/path/to/files/for/test/1/ /tank/
  $ screen -X
  $ cd ~/restic-tests/1-add_files
  $ ../run-restic-test    
  [...]    
  $ rm -rf /tank/*
  $ screen -X
  $ cd ~/restic-tests/5-restore
  $ ../run-restic-restore-test
  ```

## Collect Results and Fix File Formatting
>Prerequisites: POSIX shell, GNU `sed` (see note below), and `Rscript`.

After performing all the tests for all the backup clients you want to compare,
run a few scripts to collect all the data in one place and to create tidy CSV
flat files measurements during each test. For more information about these
scripts, refer to the comments and help text in each script.

Run the following scripts with `./data` as the working directory:

```sh
$ cd ./data
```

Collect all the test output files in the data directory:

```sh
$ ls ../materials/*/*/*.txt | xargs -n 1 ../scripts/collect_files.sh
```

Fix XML output from netstat and vmstat:

>Note: the next two scripts assume you're using GNU `sed`. To run them on macOS
>or BSD, install GNU sed, and edit the script to point to that, such as by
>replacing `sed` with `gsed`.

```sh
$ ls ./*netstat.txt | xargs -n 1 ../scripts/fix_netstat_output.sh
$ ls ./*vmstat.txt | xargs -n 1 ../scripts/fix_vmstat_output.sh
```

Generate CSV files from the XML:

>Note: the output_generic_csv.R script creates a CSV from the netstat ouptut
>without needing to parse each XML node, but the vmstat output needs some
>special handling. Expect the second script to take much longer.

```sh
$ ls *netstat.xml | xargs -n 1 -I{} Rscript ../scripts/output_generic_csv.R {}
$ ls *vmstat.xml | xargs -n 1 -I{} Rscript ../scripts/output_vmstat_csv.R {}
```

After you run these scripts, the data from each client and each test case is
available for you to review as a CSV in the `./data` directory.

## (Optional) Create Plots to Compare Results for Each Test
>Prerequisites: `Rscript` or an R workspace

You can make line graphs like the ones in my test data by using an R script. The
provided script covers all the potential graphs in one file with instructions
to comment out or uncomment different sections, depending on which variable you
want to plot during which test.

You need to modify the script each time you run it to generate the plots. There
are four potential variables:
* Sent bytes (from netstat when backing up)
* Received bytes (from netstat when restoring)
* Memory usage stats (from vmstat during all tests)
* CPU usage stats (from vmstat during all tests)

Because the first two are mutually exclusive, you can create up to three graphs
of different measurements for each of six tests, modifying and running the
script file a total of 18 times.

Repeat the following steps for each graph you want to make:
1. Open the file `./scripts/make_plots.R` in a text editor.
2. Search for the text `***`, and follow the instructions at each marked comment to make the required edits. A comment near the end of the file lets you know when you're done.
3. Run the script with `./data` as the working directory:
```sh
$ cd ./data
$ Rscript ../scripts/make_plots.R
```

>Note: If you prefer to work in a traditional R workspace, you can instead
>copy and paste the script at the R prompt.

Your plot is saved as an SVG file in the `./data` directory with the test and
the variable measured as the file name, such as 1-add_files_vmstat_cpu.svg.

### (Optional) Create a PDF Containing All Graphs
>Prerequisites: `pandoc`, `rsvg-convert`, and a supported PDF creation engine,
>such as the LaTeX compilers included in TeX Live.

The `./graphsheet` directory contains a markdown file that presents all the
graphs. After creating graphs, you can use `pandoc` to generate a PDF version
by running `pandoc -o graphsheet.pdf graphsheet.md`.

## Someday Maybe
Here are some changes I'd like to make if I were to run the tests again:
* Improve backup scripts to better model safe, real-world use by pointing to
files for all credentials and including file permission steps in client-specific
setup.
* Use git-secrets for credentials to make it safe for you to fork this
repository and post your own results without needing to manually set, then
strip out keys and passwords.
* Add more backup clients, and use measurement tools that are easier to parse
than FreeBSD libxo XML output.
* Improve plot script to suck in all the test cases at once without needing
tweaks for each one.
