#!/bin/bash

imageURL=https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
imageName="focal-server-cloudimg-amd64.img"
volumeName="SSD"
virtualMachineId="7000"
templateName="ubuntu-cloud-image"
tmp_cores="2"
tmp_memory="2048"

rm *.img
wget -O $imageName $imageURL
qm destroy $virtualMachineId
qm create $virtualMachineId --name $templateName --memory $tmp_memory --cores $tmp_cores --net0 virtio,bridge=vmbr0
qm importdisk $virtualMachineId $imageName $volumeName
qm set $virtualMachineId --scsihw virtio-scsi-pci --scsi0 $volumeName:vm-$virtualMachineId-disk-0
qm set $virtualMachineId --ide2 $volumeName:cloudinit
qm set $virtualMachineId --boot c --bootdisk scsi0
qm set $virtualMachineId --serial0 socket --vga serial0
