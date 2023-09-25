#!/bin/bash

# PROJECT_DIRECTORY="zephyr/samples/basic/blinky"
PROJECT_DIRECTORY="zephyr/samples/subsys/usb/cdc_acm_composite"

WORKING_DIR="${PWD}"
BUILD_DIR="${WORKING_DIR}/build/"

source .venv/bin/activate

function clean_build_dir {
    rm -r ${BUILD_DIR}
}

function build {
    west build -p auto ${PROJECT_DIRECTORY} --build-dir ${BUILD_DIR} -b nrf5340dk_nrf5340_cpuapp
}

while getopts 'cba:' OPTION; do
  case "$OPTION" in
    c)
      echo "Cleaning build directory"
      clean_build_dir
      ;;
    b)
      echo "Building solution.."
      build
      ;;
    a)
      avalue="$OPTARG"
      echo "The value provided is $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

