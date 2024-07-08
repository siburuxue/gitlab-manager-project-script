# gitlab-manager-project-script

[英文](README.md) | 中文

基于gitlab的项目管理脚本

假如你是个普通的开发者，最低权限的那种，在把这些脚本复制到项目根目录之后，需要一些基础设置：
```shell
chmod +x *.sh
./rename.sh
./do-ignore.sh 
```

脚本的用法：
- 创建分支(每次重新创建分支都基于dev分支)
```shell
# 3379为任务ID
./create_fetch.sh TOERP-3379
```
- 删除分支(删除TOERP-3379)
```shell
./del_br.sh 3379
```
- 推送已提交信息
```shell
./push.sh
```
- 在TOERP-3379开发完成，并且合并到dev分支后，将TOERP-3379分支合并到test分支进行测试，基于test新建分支TOERP-3379_20240708122037，并且在dev分支中找到TOERP-3379这个分支中所有的commit id 并合并到TOERP-3379_20240708122037这个新的分支上
```shell
./test.sh TOERP-3379
```
- 将TOERP-3379合并到pre环境和线上环境同上
```shell
./pre.sh TOERP-3379
./online TOERP-3379
```
- 将某几个commit id合并到dev，test，pre，新建的分支名由第一个commit id所在的分支名决定，比如第一个commit id坐在分支为TOERP-3380，并且合并到test分支上，那么会基于test分支新建分支TOERP-3380_20240708134423，然后把这几个commit id合并到新建分支上
```shell
./cherry-pick-list.sh test xxxx xxxx xxxx xxxx
```
- 更新当前分支
```shell
./rebase.sh
```
- 更新指定分支
```shell
./rebase.sh test
```
- 更新dev，test，pre，master分支，并且最终切换到当前开发分支
```shell
./all_rebase.sh
```
- 切换到某个分支(TOERP-3380)
```shell
./switch_branch.sh 3380
```
- 发送提测邮件，`TOERP-3379`为`jira`的任务ID，在`comprehensive_test.sh`脚本中设置jira账号，密码信息，邮件title中的信息包含有jira中任务ID的任务名称，避免发送测试邮件时开发同事自己写，影响测试组同事最终统计工作量。
- 因为发送提测邮件可能抄送很多人，所以没有用linux中的mail命令，而是通过go来实现最终发送邮件的功能
```shell
# 仅查看发送邮件信息
./comprehensive_test.sh TOERP-3379
# 发送邮件
./comprehensive_test.sh TOERP-3379 -a mail
# 发送邮件到指定邮箱
./comprehensive_test.sh TOERP-3379 -a mail -t xxx2@mail.com
```