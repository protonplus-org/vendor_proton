# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

# telephony
$(call inherit-product, vendor/proton/config/telephony.mk)

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Google apps and services

ifeq ($(WITH_GAPPS),true)
$(call inherit-product, vendor/gms/products/*.mk)
endif

# Gboard side padding
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_l=4 \
    ro.com.google.ime.kb_pad_port_r=4 \
    ro.com.google.ime.kb_pad_land_l=64 \
    ro.com.google.ime.kb_pad_land_r=64


# Google features
PRODUCT_COPY_FILES += \
    vendor/proton/prebuilt/common/etc/sysconfig/google_build.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/google_build.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/lily_experience.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/lily_experience.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/nexus.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/nexus.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_2016_exclusive.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_experience_2017.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2017.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_experience_2018.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2018.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_experience_2019.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2019.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_experience_2019_midyear.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2019_midyear.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_experience_2020.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2020.xml \
    vendor/proton/prebuilt/common/etc/sysconfig/pixel_experience_2020_midyear.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_experience_2020_midyear.xml

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

# Blur
ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# Disable blur on app-launch
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0

# ProtonPlus-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/proton/prebuilt/common/etc/init/init.proton-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.proton-system_ext.rc

# Enable gestural navigation overlay to match default navigation mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural;com.google.android.systemui.gxoverlay

# priv-app permissions
PRODUCT_COPY_FILES += \
    vendor/proton/prebuilt/common/etc/permissions/priv-app_system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/priv-app_system.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# protonplus packages
PRODUCT_PACKAGES += \
    RepainterServicePriv

ifeq ($(PROTON_BUILD_VARIANT),OFFICIAL)
PRODUCT_PACKAGES += \
    Updater

PRODUCT_COPY_FILES += \
    vendor/proton/prebuilt/common/etc/init/init.proton-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.proton-updater.rc
endif

# Charger
PRODUCT_PACKAGES += \
    product_charger_res_images

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig

# Disable RescueParty due to high risk of data loss
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Extra tools in ProtonPlus
PRODUCT_PACKAGES += \
    7z \
    bash \
    curl \
    getcap \
    htop \
    lib7z \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    zip

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

# Navbar
PRODUCT_PACKAGES += \
    NavigationBarModeGesturalOverlayFS

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

PRODUCT_COPY_FILES += \
    vendor/proton/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Root
PRODUCT_PACKAGES += \
    adb_root
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/proton/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/proton/overlay/common \
    vendor/proton/overlay/no-rro

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Use the default charger mode images
PRODUCT_PACKAGES += \
    charger_res_images

# CustomPixelLauncherOverlay
PRODUCT_PACKAGES += \
    CustomPixelLauncherOverlay

# Themes
PRODUCT_PACKAGES += \
    BlackTheme \
    ThemePicker
    
# BootAnimation
include vendor/proton/config/bootanimation.mk

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= $(TARGET_SUPPORTS_64_BIT_APPS)

ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    ParanoidSense

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service.enabled=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Apps
PRODUCT_PACKAGES += \
    Aperture

PRODUCT_PACKAGES += \
    NetworkStackOverlay \
    NavigationBarNoHintOverlay

ifneq ($(WITH_GAPPS),true)
PRODUCT_PACKAGES += \
    Eleven \
    Etar \
    ExactCalculator \
    Jelly
endif

ifneq ($(WITH_GAPPS),true)
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/proton/overlay/aperture
endif

# Fonts
include vendor/proton/config/fonts.mk

include vendor/proton/config/version.mk
