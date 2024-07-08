#!/bin/bash
# ./comprehensive_test.sh -j TOERP-4732
# ./comprehensive_test.sh -j TOERP-4732 -a mail
# ./comprehensive_test.sh -j TOERP-4732 -a mail -t xxx@mail.com
action=""
to=""
branch=""

while getopts ":j:a:t:h" optname
do
  case "$optname" in
    "j")
      branch="$OPTARG"
      ;;
    "a")
      action="$OPTARG"
      ;;
    "t")
      to="$OPTARG"
      ;;
    "h")
      echo "./comprehensive_test.sh -j TOERP-4732"
      echo "./comprehensive_test.sh -j TOERP-4732 -a mail"
      echo "./comprehensive_test.sh -j TOERP-4732 -a mail -t xxx@mail.com"
      echo ""
      echo "Usage: comprehensive_test [OPTIONS]"
      echo "    -j       jira number"
      echo "    -a       the action after string implode,send a mail for example"
      echo "    -t       the receive address in the mail"
      exit
      ;;
    *)
      echo "unknow options $optname "
      ;;
  esac
done

username='xxx'
password='xxx'
protocol='http'
host='jira.xxxxx.com'
uri='/rest/api/latest/issue'

if [ $# -lt 1 ]; then
  echo "the branch name cannot be empty"
  exit
fi

url="${protocol}://${username}:${password}@${host}${uri}/${branch}"
resp=`curl $url`
epic=`echo $resp|jq -r .fields.customfield_10000`
url1="${protocol}://${username}:${password}@${host}${uri}/${epic}"
resp1=`curl $url1`
version=`echo $resp1|jq -r .fields.summary|grep -oE "\d{2}"`
summary=`echo $resp|jq -r .fields.summary`
title="${branch} 【基础服务${version}.0】${summary} 提测"
pre_url="http://jira.xxxxxx.com/browse/"
name="xxx xxx"

echo "$title"
echo ""
echo "Dear all"
echo ""
echo "${summary}，已经部署至pre 请测试~"
echo ""
echo "${pre_url}${branch}"
echo ""
echo "开发人员"
echo ""
echo "${name}"

# shellcheck disable=SC2170
if [ "$action" = "mail" ];then
  spec="<br><br>"
  body="Dear all${spec}${summary}，已经部署至pre 请测试~${spec}${pre_url}${branch}${spec}开发人员${spec}${name}"
  /Users/xxxxxx/Desktop/project/go/mail_test/main -s "$title" -b "$body" -t "$to"
fi
