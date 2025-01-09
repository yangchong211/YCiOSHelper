//
//  shell2.sh
//  WanAndroidSdk
//
//  Created by 杨充 on 2024/12/19.
//

#!/bin/sh

# 参考：https://juejin.cn/post/7232187022398898234

# 取得build的target名（get project name）
FRAMEWORK_NAME=${PROJECT_NAME}

UNIVERSAL_OUTPUT_FOLDER="${SRCROOT}/Products"

UNIVERSAL_PRODUCT_PATH="${UNIVERSAL_OUTPUT_FOLDER}/${FRAMEWORK_NAME}.framework"

#创建输出目录，并删除之前的framework文件
if [ ! -d "${UNIVERSAL_OUTPUT_FOLDER}" ];then
    mkdir -p "${UNIVERSAL_OUTPUT_FOLDER}"
fi

if [ -d "${UNIVERSAL_PRODUCT_PATH}" ];then
    rm -rf "${UNIVERSAL_PRODUCT_PATH}"
fi

# 设置真机和模拟器生成的静态库路径 （set devcie framework and simulator framework path）  ${TARGET_NAME}
DEVICE_DIR="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework"
SIMULATOR_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework"

#分别编译模拟器和真机的Framework
xcodebuild -target "${FRAMEWORK_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
xcodebuild -target "${FRAMEWORK_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

#拷贝framework到univer目录
cp -R "${DEVICE_DIR}" "${UNIVERSAL_OUTPUT_FOLDER}"

#移除 iphonesimulator 里的 arm64
lipo -remove arm64 "${SIMULATOR_DIR}/${FRAMEWORK_NAME}" -output "${SIMULATOR_DIR}/${FRAMEWORK_NAME}"

#合并framework，输出最终的framework到build目录
lipo -create -output "${UNIVERSAL_OUTPUT_FOLDER}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${DEVICE_DIR}/${FRAMEWORK_NAME}" "${SIMULATOR_DIR}/${FRAMEWORK_NAME}"

#判断build文件夹是否存在，存在则删除
if [ -d "${SRCROOT}/build" ]
then
rm -rf "${SRCROOT}/build"
fi

rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator" "${BUILD_DIR}/${CONFIGURATION}-iphoneos"

#打开合并后的文件夹
open "${UNIVERSAL_OUTPUT_FOLDER}"

