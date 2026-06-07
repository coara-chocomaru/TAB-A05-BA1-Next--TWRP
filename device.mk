#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
LOCAL_PATH := device/sts/a05ba 
#PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true
#PRODUCT_ENFORCE_RRO_TARGETS := *


# API levels
#PRODUCT_USE_DYNAMIC_PARTITIONS := false
#PRODUCT_BUILD_SUPER_PARTITION := false
#PRODUCT_TARGET_VNDK_VERSION := 28
#PRODUCT_EXTRA_VNDK_VERSIONS := 28
#PRODUCT_SHIPPING_API_LEVEL := 28
#PRODUCT_FIRST_API_LEVEL := 28


# drm
#PRODUCT_PACKAGES += kisd
#PRODUCT_PACKAGES += liburee_meta_drmkeyinstall_v2
#PRODUCT_PROPERTY_OVERRIDES += ro.mtk_key_manager_kb_path=4

#telephony
#PRODUCT_PACKAGES -= TeleService
#PRODUCT_PACKAGES -= CellBroadcastReceiver
#PRODUCT_PACKAGES -= MmsService
#PRODUCT_PACKAGES -= Stk
#PRODUCT_PACKAGES -= CarrierConfig

#nfc
#PRODUCT_PACKAGES -= \
    Nfc \
    com.android.nfc \
    Tag \
    libnfc \
    libnfc_jni \
    nfc_nci

# Product characteristics
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_PROPERTY_OVERRIDES += ro.radio.noril=true
PRODUCT_PACKAGES += coara

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.build.product=TAB-A05-BA1 \
    ro.product.board=TAB-A05-BA1 \
    ro.product.device=TAB-A05-BA1 \
    ro.product.locale=ja-JP \
    ro.build.system_root_image=true \
    persist.sys.locale=ja-JP \
    ro.treble.enabled=true \
    ro.build.characteristics=tablet \
    ro.product.first_api_level=28

# Soft keys
#PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=0

#PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
　　 update_engine \
    update_verifier \
    update_engine_sideload

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Copy files
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/init.ago.rc:vendor/etc/init/hw/init.ago.rc \
    $(LOCAL_PATH)/etc/init.connectivity.rc:vendor/etc/init/hw/init.connectivity.rc \
    $(LOCAL_PATH)/etc/init.modem.rc:vendor/etc/init/hw/init.modem.rc \
    $(LOCAL_PATH)/etc/init.mt8168.rc:vendor/etc/init/hw/init.mt8168.rc \
    $(LOCAL_PATH)/etc/init.mt8168.usb.rc:vendor/etc/init/hw/init.mt8168.usb.rc \
    $(LOCAL_PATH)/etc/init.project.rc:vendor/etc/init/hw/init.project.rc \
    $(LOCAL_PATH)/etc/init.sensor_1_0.rc:vendor/etc/hw/init/init.sensor_1_0.rc \
    $(LOCAL_PATH)/etc/meta_init.connectivity.rc:vendor/etc/init/hw/meta_init.connectivity.rc \
    $(LOCAL_PATH)/etc/meta_init.modem.rc:vendor/etc/init/hw/meta_init.modem.rc \
    $(LOCAL_PATH)/etc/meta_init.project.rc:vendor/etc/init/hw/meta_init.project.rc \
    $(LOCAL_PATH)/etc/meta_init.rc:vendor/etc/init/hw/meta_init.rc \
    $(LOCAL_PATH)/etc/multi_init.rc:vendor/etc/init/hw/multi_init.rc \
    $(LOCAL_PATH)/etc/fstab.mt8168:vendor/etc/fstab.mt8168 \
    $(LOCAL_PATH)/etc/ueventd.mt8168.rc:vendor/ueventd.rc

#PRODUCT_PACKAGES += \
    android.hardware.audio@4.0-service-mediatek \
    android.hardware.audio.effect@4.0-service-mediatek

# Bluetooth HAL
#PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-service-mediatek

# Light HAL
#PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service-mediatek

# Wi-Fi HAL & tools
#PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi@1.0-service-mediatek \
    wpa_supplicant \
    wificond \
    libwifi \
    libwpa_client \
    wpa_supplicant_legacy \
    dhcpclient \
    hostapd \
    libnetutils \
    libdpm \
    libnl \
    libpcap \
    wifi-service \
    WifiOverlay

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)


# Inherit vendor blobs
#$(call inherit-product, vendor/sts/a05ba/a05ba-vendor.mk)
