#!/bin/bash

# ----- ----- ----- -----
# freepbx os从头安装完成后, clone本仓库
# bash WP_replace.sh 替换部分文件
# ----- ----- ----- -----

set -u

# 功能：去除目录，保存原目录到 /opt, 自己改的目录不存
# logic: 确认 /opt 目录是否已经存在，没有就移动，有就直接删除
removeDir() {
  local dir=`basename $1`
  
  # 如果提供的目录名末尾有 * , 需要遍历查找
  if [[ ${dir:-1} == '*' ]]; then  
    # 这里用不到这个逻辑了，每个输入的模块都是从数组中读取的全名
    return 0;
  fi
  
  # 本来就没有的话就不用移动了
  if [ ! -e $1 ]; then return 0; fi

  if [ -d "/opt/${dir}.bak" ]; then sudo rm -r $1
  else 
    sudo mv $1 /opt/${dir}.bak
  fi
}

# 获取需要替换的模块名列表, 只认特定前缀的
getModuleArr() {
  local dList=()
  for d in `pwd`/modules/*
  do
    if [[ -d "$d" ]]; then
      local moduleName=`basename $d`;
      # 前缀是 new_ 的都算
      if [[ ${moduleName%_*} == "new" ]]; then dList+=($d); fi
      if [[ ${moduleName%_*} == "WP" ]]; then dList+=($d); fi
      if [[ ${moduleName%_*} == "qianlue" ]]; then dList+=($d); fi     
    fi
  done
  echo ${dList[*]}
}

replaceModule() {
  local dList=`echo $@` 
  echo "替换 $# 个模块";

  for d in ${dList[*]}
  do
    echo $d;
    local moduleName=`basename $d`
    # 放置模块的真实路径
    local pathModule="/var/www/html/admin/modules/${moduleName}"

    removeDir $pathModule
    sudo cp -r $d ${posSrc}/modules/
    # 模块的样式表软链接
    sudo rm ${posSrc}/assets/${moduleName}
    sudo ln -s ${pathModule}/assets ${posSrc}/assets/${moduleName}
  done
}

# ----- ----- main ----- -----
posSrc="/var/www/html/admin"

# 自定义模块替换/新增
moduleArr=($(getModuleArr))
arg1=`echo ${moduleArr[*]}`
replaceModule $arg1

# 界面框架本身替换
op=0
read -p "框架本身样式更新? [Y/n] " op
case $op in 
  Y | y | 1) ;;
  *) exit
esac

removedir ${posSrc}/assets/less/freepbx
removedir ${posSrc}/views

sudo cp -r ./asstes/less/freepbx ${posSrc}/asstes/less/
sudo cp -r ./views ${posSrc}
