#!/usr/bin/env bash

img_registry='docker.io/library'
img_name='perl'
image_tag='latest'
cnt_name='ora2pg'
cnt_volume=$(pwd)


podman run \
  --detach \
  --tty \
  --interactive \
  --name "${cnt_name}" \
  --volume "${cnt_volume}":/opt/ora2pg \
"${img_registry}"/"${img_name}":"${image_tag}"
