# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# ProtonPlus System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.proton.version=$(PROTON_VERSION) \
    ro.proton.releasetype=$(RELEASE_TYPE) \
    ro.proton.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(PROTON_VERSION) 

ifeq ($(WITH_GAPPS),true)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.proton.ziptype=gapps
else
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.proton.ziptype=vanilla
endif

# ProtonPlus Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.proton.display.version=$(PROTON_VERSION)
