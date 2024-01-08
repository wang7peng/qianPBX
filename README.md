```
        _               ______ ______ __   __
       (_)              | ___ \| ___ \\ \ / /
  __ _  _   __ _  _ __  | |_/ /| |_/ / \ V / 
 / _` || | / _` || '_ \ |  __/ | ___ \ /   \ 
| (_| || || (_| || | | || |    | |_/ // /^\ \
 \__, ||_| \__,_||_| |_|\_|    \____/ \/   \/
    | |                                      
    |_|        
Your Close Source Asterisk PBX GUI Solution    
```
### What?

安装完 freepbx 后, 在原先界面基础上修改, 使布局、按钮控制等操作符合我们的习惯。

使用的版本: SNG7-PBX16-64bit-2302-1.iso (CentOS7)

### Where?

`cd /var/www/html/admin/views/`

# 用法

在ISO安装完成后, 直接执行根目录的 `WP_replace.sh` 脚本，它会自动替换原先的一些目录。。

```bash
cd /var/www/html/admin
git clone --branch qianPBX https://github.com/qianlue123/adminQian.git
cd adminQian
sudo bash WP_replace.sh
```

## 本地目录结构

```
admin/
├── assets
│   ├── ...
│   └── less
│       ├── ...
│       └── freepbx/    # 样式表目录
│           ├── ...
│           └── *.less
├── ...
├── modules             # 所有的模块
│   ├── core
│   │   └── page.extensions.php   # 分机信息
│   ├── ...
│   ├── new_*           # 公司的
│   └── WP_*            # 自己试的
└── views               # 页面对应的实际代码
    ├── ...
    └── *.php
```

Application 导航里的分机模块是自带的。其他的 `IP/admin/config.php?display=xxx` 的 xxx 大多在 modules 目录一个对应的目录专门存放它。并且在 github 可以找到源码。

**Note** 无论在哪个模块界面，点击了功能提交按钮后，要点击右上角跳出的 “更新配置” 红色按钮，然后等几秒就起作用，它会自动去更新 `/etc/asterisk/` 目录下的 conf 配置文件，并且在 `/etc/asterisk/ari_additional.conf` 的密码会自动修改。

# 参考

- [Sangoma 界面统一准则](https://sangomakb.atlassian.net/wiki/spaces/FP/pages/10093035/Uniformity+Guidelines)
