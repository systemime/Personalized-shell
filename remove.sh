#!/bin/bash

if [ `id -u` -eq 0 ];then
    TRASH_DIR="/opt/.trash"  
    DELFILE="/opt/.trash/.wherefile.log"
else
    TRASH_DIR="/home/cc/.trash"  
    DELFILE="/home/cc/.trash/.wherefile.log"
fi

if [ ! -d "$TRASH_DIR" ]; then
  mkdir "$TRASH_DIR"
  touch "$DELFILE"
fi

if [ ! -f "$DELFILE" ]; then
  touch "$DELFILE"
fi

for i in $*; do 
    # if [[ $i =~ -+. ]]; then
    # echo "No need to carry parameters..."
    # exit
    # else
    STAMP=`date +%Y%m%d%H%M%S`  
    fileName=`basename $i` 
    wherefile=`readlink -f $i`
    tar -zcpf $i.tar.gz $i >> /dev/null 
    rm -rf $i >> /dev/null 
    mv $i.tar.gz $TRASH_DIR/$fileName.tar.gz.$STAMP >> /dev/null 
    cat <<EOF >>$DELFILE
    $wherefile $STAMP
EOF
# fi
done