#!/bin/bash
# Script to format, mount EBS volumes, and add to fstab
sleep 10
%{ for vol in volumes }
# Format and mount ${vol.device_name} to ${vol.mount_point}
  mkfs -t xfs ${vol.device_name}
  if [ ! -d "${vol.mount_point}" ]; then
    mkdir -p "${vol.mount_point}"
  fi
  mount -t xfs ${vol.device_name} ${vol.mount_point}
  echo "${vol.device_name} ${vol.mount_point} xfs defaults,nofail 0 2" >> /etc/fstab
%{ endfor }
  mount -a
