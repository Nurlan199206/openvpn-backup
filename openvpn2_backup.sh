#!bin/bash
fold=$(date +%Y%m%d)
time=$(date +%T%)
rsync=100
/usr/bin/expect -f /home/nurlan/ask
sleep 25
if
/sbin/mount.cifs //10.8.0.1/data/ /mnt/1C/ -o dom=WORKGROUP,user=test,pass=test
then echo "remote share \\data on 10.8.0.1 mounted at $time"
else echo "remote share on 10.8.0.1 not mounted at $time" && ps -ef | grep openvpn | grep -v grep | awk '{print $2}' | xargs kill
exit 0
fi
sleep 10
if
mount -t cifs //172.27.1.50/1C/ /mnt/nas -o dom=WORKGROUP,user=test,pass=test,vers=2.0
then echo "NAS remote share folder mounted at $time"
fi
sleep 10
rsync -av --progress /mnt/1C/CCG/base/ /mnt/nas/$fold
if [ "$rsync" -eq "100" ]
then echo "backed up successfully... unmounting remote shares /mnt/nas and /mnt/1C and terminating OpenVPN connection at $time" && umount -l /mnt/nas && umount -l /mnt/1C
else
echo "Backup failed..."
fi
sleep 10
ps -ef | grep openvpn | grep -v grep | awk '{print $2}' | xargs kill
