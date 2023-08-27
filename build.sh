#!/bin/bash

WORKING_DIR="${PWD}"
BUILD_DIR="${working_dir}/build/"

. .venv/bin/activate
west build -p auto zephyr/samples/basic/blinky --build-dir ${build_dir} -b nrf5340dk_nrf5340_cpuapp
