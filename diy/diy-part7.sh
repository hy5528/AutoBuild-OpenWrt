#!/bin/bash
#=================================================
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#=================================================

# 修改默认IP
sed -i 's/192.168.1.1/10.32.0.1/g' package/base-files/files/bin/config_generate
# 修改网关
sed -i 's/192.168.$((addr_offset++)).1/10.32.$((addr_offset++)).1/g' package/base-files/files/bin/config_generate

# 修改主机名称
sed -i 's/OpenWrt/Yuos/g' package/base-files/files/bin/config_generate



# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="MOLUN"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"MOLUN"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config

# 修改 edge 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
#sed -i 's/luci-theme-bootstrap/luci-theme-edge/g' openwrt/feeds/luci/collections/luci/Makefile

#Enable 802.11k/v/r
#sed -i 's/RRMEnable=0/RRMEnable=1/g' package/kernel/mt-drivers/mt_wifi/files/mt7615.1.2G.dat
#sed -i 's/RRMEnable=0/RRMEnable=1/g' package/kernel/mt-drivers/mt_wifi/files/mt7615.1.5G.dat
#sed -i 's/FtSupport=0/FtSupport=1/g' package/kernel/mt-drivers/mt_wifi/files/mt7615.1.2G.dat
#sed -i 's/FtSupport=0/FtSupport=1/g' package/kernel/mt-drivers/mt_wifi/files/mt7615.1.5G.dat
#echo 'WNMEnable=1' >> package/kernel/mt-drivers/mt_wifi/files/mt7615.1.2G.dat
#echo 'WNMEnable=1' >> package/kernel/mt-drivers/mt_wifi/files/mt7615.1.5G.dat