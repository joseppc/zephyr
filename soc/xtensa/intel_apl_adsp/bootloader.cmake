# Copyright (c) 2019 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

add_subdirectory(${SOC_DIR}/${ARCH}/${SOC_FAMILY}/common/bootloader ${build_dir})

add_custom_target(
  process_elf ALL
  DEPENDS base_module
  DEPENDS ${ZEPHYR_FINAL_EXECUTABLE}
  COMMAND ${CMAKE_OBJCOPY} --dump-section .data=mod-apl.bin ${CMAKE_BINARY_DIR}/zephyr/soc/xtensa/${SOC_FAMILY}/common/bootloader/libbase_module.a
  COMMAND ${CMAKE_OBJCOPY} --add-section .module=mod-apl.bin --set-section-flags .module=load,readonly ${CMAKE_BINARY_DIR}/zephyr/zephyr.elf ${CMAKE_BINARY_DIR}/zephyr/zephyr.elf.mod
  )

add_custom_target(
  process_bootloader ALL
  DEPENDS bootloader boot_module
  COMMAND ${CMAKE_OBJCOPY} --dump-section .data=mod-boot.bin ${CMAKE_BINARY_DIR}/zephyr/soc/xtensa/${SOC_FAMILY}/common/bootloader/libboot_module.a
  COMMAND ${CMAKE_OBJCOPY} --add-section .module=mod-boot.bin --set-section-flags .module=load,readonly ${CMAKE_BINARY_DIR}/zephyr/soc/xtensa/${SOC_FAMILY}/common/bootloader/bootloader.elf ${CMAKE_BINARY_DIR}/zephyr/bootloader.elf.mod
  )
