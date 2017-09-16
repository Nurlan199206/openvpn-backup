#!bin/bash
fold=$(date +%Y%m%d)
./ask
sleep 25
if
mount -t cifs //10.8.0.1/data/ /mnt/1C/ -o dom=WORKGROUP,user=user,pass=password
then echo "remote share \\data on 10.8.0.1 mounted"
else echo "not mounted"
fi
sleep 10
if
mount -t cifs //172.27.1.50/1C/ /mnt/nas -o dom=WORKGROUP,user=user,pass=password,vers=2.0
then echo "NAS remote share folder mounted..."
fi
rsync -rPz --progress /mnt/1C/CCG/base/ /mnt/nas/$fold
sleep 2h
if
umount -l /mnt/1C
then echo "//mnt/1C succesfully unmounted..."
else "//mnt/1C unmount failed..."
fi
sleep 10
if
umount -l /mnt/nas
then
echo "/mnt/nas succesfully unmounted..."
else "/mnt/nas unmount failed..."
fi
sleep 10
ps -ef | grep openvpn | grep -v grep | awk '{print $2}' | xargs kill
