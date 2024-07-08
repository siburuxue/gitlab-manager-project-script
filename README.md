# gitlab-manager-project-script

English | [Chinese](README_zh.md)

Script for project management based on GitLab.

Assuming you are an ordinary developer with minimal permissions, after copying these scripts to the project root directory, you need some basic setup:

```shell
chmod +x *.sh
./rename.sh
./do-ignore.sh
```
Usage of scripts:

- Create branch (each new branch is based on the dev branch):
```shell
# 3379 is the task ID
./create_fetch.sh TOERP-3379
```
- Delete branch (delete TOERP-3379):
```shell
./del_br.sh 3379
```
- Push committed changes:
```shell
./push.sh
```
After completing development on TOERP-3379 and merging it into the dev branch, merge the TOERP-3379 branch into the test branch for testing. Create a new branch TOERP-3379_20240708122037 based on test, and merge all commit IDs from TOERP-3379 in the dev branch into this new branch:
```shell
./test.sh TOERP-3379
```
- Merge TOERP-3379 into pre-production and production environments:
```shell
./pre.sh TOERP-3379
./online TOERP-3379
```
- Merge specific commit IDs into dev, test, pre environments. The new branch name is determined by the branch where the first commit ID is found. For example, if the first commit ID is on the TOERP-3380 branch and it's merged into the test branch, a new branch TOERP-3380_20240708134423 will be created based on test, and these commit IDs will be merged into the new branch:
```shell
./cherry-pick-list.sh test xxxx xxxx xxxx xxxx
```
- Update current branch:
```shell
./rebase.sh
```
- Update specified branch:
```shell
./rebase.sh test
```
- Update dev, test, pre, master branches and switch back to the current development branch:
```shell
./all_rebase.sh
```
- Switch to a specific branch (TOERP-3380):
```shell
./switch_branch.sh 3380
```
- Send test email. TOERP-3379 is the Jira task ID. Configure Jira account credentials in comprehensive_test.sh. The email title includes the task name corresponding to the Jira task ID to prevent developers from writing their own test emails, affecting the final workload statistics of the testing team:
Since sending test emails may involve many recipients, Linux mail command is not used. Instead, sending emails is implemented using Golang:
```shell
# View email details without sending
./comprehensive_test.sh TOERP-3379
# Send email
./comprehensive_test.sh TOERP-3379 -a mail
# Send email to a specific email address
./comprehensive_test.sh TOERP-3379 -a mail -t xxx2@mail.com
```
This document outlines the functionalities and usage of the GitLab project management scripts.