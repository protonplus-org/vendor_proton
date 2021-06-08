# Fonts
LOCAL_PATH := vendor/proton/fonts
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/ttf,$(TARGET_COPY_OUT_PRODUCT)/fonts)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

PRODUCT_PACKAGES += \
    RobotoFallback-BlackItalic.ttf \
    RobotoFallback-Black.ttf \
    RobotoFallback-BoldItalic.ttf \
    RobotoFallback-Bold.ttf \
    RobotoFallback-Italic.ttf \
    RobotoFallback-LightItalic.ttf \
    RobotoFallback-Light.ttf \
    RobotoFallback-MediumItalic.ttf \
    RobotoFallback-Medium.ttf \
    RobotoFallback-Regular.ttf \
    RobotoFallback-ThinItalic.ttf \
    RobotoFallback-Thin.ttf 

