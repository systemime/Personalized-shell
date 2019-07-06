# Personalized-shell
使用linux过程中，创建文件夹后繁琐的cd，rm命令懊恼或者麻烦的数据恢复等等这些问题，我会编写自己的符合我愿望的shell脚本以增强官方的工具，让linux使用更加顺心

* **脚本自行编写，限于水平，谨慎使用**


### 使用方法一

**以创建文件夹并进入为例子**

* 传统方法：
```
mkdir 123
cd 123
```

* 你可以：
在`~/.bashrc`或`/etc/profile`中加入如下脚本
```
mkcd()
{
mkdir $1
cd $1
}
```

然后`source /etc/profile`或`source ~/.bashrc`刷新环境变量，具体使用根据你在`~/.bashrc`还是`/etc/profile`中填入了上面的内容

接下来，使用你自己的命令`mkcd filename`

你会发现新建的文件夹并自动进入

### 使用方法二
直接写入环境变量`~/.bashrc`或`/etc/profile`

### remove.sh使用
增加一个回收站，同时添加删除日志
* 方法一

编辑`~/.bashrc`或`/etc/profile`，添加
```
alias rm="sh /usr/bin/remove.sh >> /dev/null"

cclear()
{  
    read -p "clear sure?[Input 'y' or 'Y' to confirm. && Input 'n' to cancel.]" confirm   
    [ $confirm == 'y' ] || [ $confirm == 'Y' ]  && /bin/rm -rf /opt/.trash/* && /bin/rm -rf /home/cc/.trash/*   
}  
```

上述代码是为了替换rm命令以及增加清空回收站函数

之后刷新环境变量`source /etc/profile`或`source ~/.bashrc`

接下来你就可以直接使用类似`rm 123`的方式删除你的文件或文件夹

**无需也不能使用 -r -f -v -i -R参数**

* 方法二
编辑`~/.bashrc`或`/etc/profile`，添加
```alias rm=delrm

delrm()
{
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
    STAMP=`date +%Y%m%d%H%M%S`  
    fileName=`basename $i` 
    wherefile=`readlink -f $i`
    tar -zcpf $i.tar.gz $i >> /dev/null 
    rm -rf $i >> /dev/null 
    mv $i.tar.gz $TRASH_DIR/$fileName.tar.gz.$STAMP >> /dev/null 
    cat <<EOF >>$DELFILE
    $wherefile $STAMP
EOF
done
}

cclear()
{  
    read -p "clear sure?[Input 'y' or 'Y' to confirm. && Input 'n' to cancel.]" confirm   
    [ $confirm == 'y' ] || [ $confirm == 'Y' ]  && /bin/rm -rf /opt/.trash/* && /bin/rm -rf /home/cc/.trash/*   
}

```
刷新环境变量就可以了
