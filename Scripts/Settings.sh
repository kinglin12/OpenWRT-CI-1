#!/bin/bash

#删除冲突主题
rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|design\).*")
#修改默认主机名
sed -i "s/OpenWrt|ImmortalWrt/$OWRT_NAME/g" ./package/base-files/files/bin/config_generate
#修改默认IP地址
sed -i "s/192.168.1.1/$OWRT_IP/g" ./package/base-files/files/bin/config_generate

#根据源码来修改
if [[ $OWRT_URL == *"lede"* ]] ; then
  #修改默认主题为Design
  sed -i 's/luci-theme-bootstrap/luci-theme-design/g' ./feeds/luci/collections/luci/Makefile
  #修改默认时间格式
  sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' $(find ./package/*/autocore/files/ -type f -name "index.htm")
else
  #修改默认主题为Argon
  sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
fi
