The official answer is available in the section "[Backup, restore, or migrate data volumes](https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes)":

# BACKUP:

```
sudo docker run --rm --volumes-from DATA -v $(pwd):/backup busybox tar cvf /backup/backup.tar /data

```

- **--rm:** remove the container when it exits
- **--volumes-from** DATA: attach to the volumes shared by the DATA container
- **-v $(pwd):/backup**: bind mount the current directory into the container; to write the tar file to
- **busybox**: a small simpler image - good for quick maintenance
- **tar cvf /backup/backup.tar /data**: creates an uncompressed tar file of all the files in the /data directory

# RESTORE:

## create a new data container

```
$ sudo docker create -v /data --name DATA2 busybox true
```

## untar the backup files into the new container᾿s data volume

```
$ sudo docker run --rm --volumes-from DATA2 -v $(pwd):/backup busybox tar xvf /backup/backup.tar
data/
data/sven.txt
```

## compare to the original container

```
$ sudo docker run --rm --volumes-from DATA -v `pwd`:/backup busybox ls /data
sven.txt
```

# See - Saving and loading image Lab-02-Containers
