# VM

Pour monter un partage dans VMware :
```bash
# pour un partage nommé partage
mkdir share
vmhgfs-fuse .host:partage ./share && echo 'vmhgfs-fuse .host:partage ./share' >> .bashrc
```
