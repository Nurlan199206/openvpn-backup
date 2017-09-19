#!bin/bash
fold=$(date +%Y%m%d)
rsync=100
/usr/bin/expect -f ask
sleep 25
if
mount -t cifs //10.8.0.1/data/ /mnt/1C/ -o dom=WORKGROUP,user=user,pass=password
then echo "remote share \\data on 10.8.0.1 mounted"
else echo "not mounted"
exit 0
fi
sleep 10
if
mount -t cifs //172.27.1.50/1C/ /mnt/nas -o dom=WORKGROUP,user=user,pass=password,vers=2.0
then echo "NAS remote share folder mounted..."
fi
rsync -rPzv --progress /mnt/1C/CCG/base/ /mnt/nas/$fold
if [ "$rsync" -eq "100" ]
then echo "backed up successfully... unmounting remote shares /mnt/nas and /mnt/1C" && umount -l /mnt/nas && umount -l /mnt/1C
else
echo "Backup failed..."
fi
sleep 10
ps -ef | grep openvpn | grep -v grep | awk '{print $2}' | xargs kill
