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
