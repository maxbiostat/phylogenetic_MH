#!/usr/bin/bash
for i in *.csv
do
#tar -cvf "$i.tar" "$i"; gzip -9 "$i.tar"
tar --use-compress-program="pigz -9 -k -p8" -cf "$i.tar.gz" "$i"
done
