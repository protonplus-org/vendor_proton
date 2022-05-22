# Copyright (C) 2020 The Proton AOSP Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CUSTOM_ROM_VERSION := 12.3.1+1.2
CUSTOM_ROM_VERSION_MAJOR := SnowCone
PROTON_HOST_TIME := $(shell date -u +%Y%m%d_%H%M%S)
TARGET_PRODUCT_SHORT := $(subst aosp_,,$(TARGET_DEVICE))

ifeq ($(PROTONPLUS_BUILD_VARIANT),OFFICIAL)
    PROTON_BUILD_VERSION := ProtonPlus-$(CUSTOM_ROM_VERSION_MAJOR)-$(TARGET_PRODUCT_SHORT)-OFFICIAL-$(PROTON_HOST_TIME)
    CUSTOM_ROM_VERSION_SHOW := $(CUSTOM_ROM_VERSION)-OFFICIAL
else
    PROTON_BUILD_VERSION := ProtonPlus-$(CUSTOM_ROM_VERSION_MAJOR)-$(TARGET_PRODUCT_SHORT)-UNOFFICIAL-$(PROTON_HOST_TIME)
    CUSTOM_ROM_VERSION_SHOW := $(CUSTOM_ROM_VERSION)-UNOFFICIAL
endif

ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.version.custom=$(CUSTOM_ROM_VERSION) \
    ro.build.version.custom.show=$(CUSTOM_ROM_VERSION_SHOW) \
    ro.build.version.device=$(TARGET_PRODUCT_SHORT) \
    ro.proton.build.version=$(CUSTOM_ROM_VERSION) \
    ro.modversion=$(CUSTOM_ROM_VERSION) 
