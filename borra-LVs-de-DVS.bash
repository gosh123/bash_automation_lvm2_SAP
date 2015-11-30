#!/bin/bash
for j in `lvdisplay | grep -i dvs | grep "LV Name" | awk '{FS=" ";print $3}' | sort`
do
  echo "Ejecutando comando: umount -v $j"
  umount -v ${j}
  echo "Ejecutando comando: lvremove -v $j"
  lvremove -v ${j}
done

