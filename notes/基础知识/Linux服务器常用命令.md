# 系统说明

多用户Linux服务器有以下特点：
- 除非额外授权（不太可能），用户不具备管理员权限，很多操作是不方便的。
- 通过ip和port定位服务器，通过`.rsa`秘钥文件（主流）或密码以单一用户远程登录服务器。

# 用户管理

显示当前用户的名称：
```shell
logname
```

显示自身用户名称：
```shell
whoami
```

查找并显示`<user_name>`用户信息：
```shell
whois <user_name>
```

显示当前用户ID：
```shell
id
```

显示当前用户群组的ID：
```shell
id -g
```

修改用户密码：
```shell
passwd <user_name>
```

显示系统用户最近登录信息：
```shell
last
```

显示系统中有哪些使用者正在上面：
```shell
who
```

变更为其他使用者的身份（需要密码）：
```shell
su <user_name>
```

# 文件管理

## 文本文件管理

创建文本文件：
```shell
touch <file_name>
```

查看文本文件行数：
```shell
wc -l <file_name>
```

查看文本文件全部内容：
```shell
cat <file_name>
```

查看文本文件前5行：
```shell
head -5 <file_name>
```

查看文本文件后10行：
```shell
tail -10 <file_name>
```

编辑文本文件：
```shell
vim <file_name>
```

分页查看文本文件（可用Space向下翻页，用b向上翻页）：
```shell
more <file_name>
```

删除特定文件：
```shell
rm <file_name>
```

## 压缩文件管理

解压tar.gz文件：
```shell
tar -zxvf <file_name>.tar.gz
```

解压zip文件：
```shell
unzip <file_name>.zip
```

## 链接文件管理


为名为`<link_source>`的文件或目录创建软链接`<link_target>`：
```shell
ln -s <link_source> <link_target>
```

为文件（不能是目录）`<link_source>`创建硬链接`<link_target>`：
```shell
ln <link_source> <link_target>
```

## 文件目录管理

切换文件目录(绝对路径或相对路径)：
```shell
cd <target_path_name>
```

创建空文件夹：
```shell
mkdir <dic_name>
```

查看当前文件夹中的全部文件(不含隐藏文件)：
```shell
ls
```

查看指定文件夹中的全部文件(不含隐藏文件)：
```shell
ls <path_name>
```

查看指定文件夹中的全部文件(含隐藏文件)：
```shell
ls -a <path_name>
```

读取标准输入的数据，并将其内容输出成文件`<log_name>`（`-a`表示追加）：
```shell
ls -l | tee -a <log_name>
```

以树状图列出`<path_name>`目录的内容（目录下的所有文件，包括子目录里的文件）：
```shell
tree <path_name>
```

以树状图列出`<path_name>`目录的内容(含隐藏文件)：
```shell
tree -a <path_name>
```

查看当前工作目录绝对路径：
```shell
pwd
```

移动文件夹：
```shell
mv <dic_name>
```

参数选项
- `-b`：当目标文件或目录存在时，在执行覆盖前，会为其创建一个备份。
- `-i`：如果指定移动的源目录或文件与目标的目录或文件同名，则会先询问是否覆盖旧文件，输入y表示直接覆盖，输入n表示取消该操作。
- `-f`：如果指定移动的源目录或文件与目标的目录或文件同名，不会询问，直接覆盖旧文件。
- `-n`：不要覆盖任何已存在的文件或目录。
- `-u`：当源文件比目标文件新或者目标文件不存在时，才执行移动操作。

移动文件夹，如果指定移动的源目录或文件与目标的目录或文件同名，则会先询问是否覆盖旧文件，输入y表示直接覆盖，输入n表示取消该操作：
```shell
mv -i <dic_name>
```

删除空文件夹：
```shell
rm <dic_name>
```

递归拷贝非空文件夹：
```shell
cp -r <dic_name>
```

递归删除非空文件夹：
```shell
rm -rf <dic_name>
```

## 文件条件检索

从环境变量`$PATH`设置的目录里查找符合条件的文件`<file_name>`：
```shell
which <file_name>
```

从特定目录`<path_name>`中查找符合条件的文件`<file_name>`（只有原始代码、二进制文件，或是man帮助文件）：
```shell
whereis -B <path_name> <file_name>
```

查找`<path_name>`目录下名为`<file_name>`的文件：
```shell
find <path_name> -name <file_name>
```

将`<path_name>`目录及其子目录下所有文件后缀为`.java`的文件列出来：
```shell
find <path_name> -name "*.java"
```

将`<path_name>`目录及其子目录中的所有文件列出：
```shell
find <path_name> -type f
```

查找`<path_name>`目录下大于1MB的文件：
```shell
find <path_name> -size +1M
```

查找`<path_name>`目录下在7天前修改过的文件：
```shell
find <path_name> -mtime +7
```

将`<path_name>`目录及其子目录下所有最近20天前更新过的文件列出：
```shell
find <path_name> -ctime 20
```

将`<path_name>`目录及其子目录下所有20天前及更早更新过的文件列出：
```shell
find <path_name> -ctime +20
```

查找`<path_name>`目录中更改时间在7日以前的普通文件，并在删除之前询问它们：
```shell
find <path_name> -type f -mtime +7 -ok rm {} \;
```

查找`<path_name>`目录中文件属主具有读、写权限，并且文件所属组的用户和其他用户具有读权限的文件：
```shell
find <path_name> -type f -perm 644 -exec ls -l {} \;
```

查找系统中所有文件长度为0的普通文件，并列出它们的完整路径：
```shell
find / -type f -size 0 -exec ls -l {} \;
```

# 权限管理

为脚本文件添加可执行权限：
```shell
chmod u+x <script_name>
```

设置个人用户目录其他用户不可访问：
```shell
chmod 700 /home/<username>
```

| 权限值 | 权限 | rwx | 二进制 |
|:----:|:----:|:----:|:----:|
| 7 | 读 + 写 + 执行 | rwx | 111 |
| 6 | 读 + 写 | rw- | 110 |
| 5 | 读 + 执行 | r-x | 101 |
| 4 | 只读 | r-- | 100 |
| 3 | 写 + 执行 | -wx | 011 |
| 2 | 只写 | -w- | 010 |
| 1 | 只执行 | --x | 001 |
| 0 | 无 | --- | 000 |

# 内存管理

显示内存状态信息：
```shell
free
```

# 磁盘管理

统计文件系统磁盘使用情况：
```shell
df -h
```

显示指定的目录或文件所占用的磁盘空间：
```shell
du
```

# 进程管理

查找指定格式信息`<info>`的进程：
```shell
ps -ef | grep <info>
```

查看对应用户的进程：
```shell
top -u <username>
```

查看对应进程`<pid>`的所属用户：
```shell
ps u <pid>
```

查看本用户所有的进程：
```shell
ps ux
```

杀死指定用户进程：
```shell
kill -9 <pid>
```
或
```shell
kill -15 <pid>
```

将所有进程以树状图显示（显示用户名）：
```shell
pstree -u
```

# 网络管理

网络文件下载：
```shell
wget <url>
```

向`<url_name>`发送HTTP-GET请求（推荐阅读：[curl的用法指南](https://www.ruanyifeng.com/blog/2019/09/curl-reference.html)）：
```shell
curl <url_name>
```

显示网络设备信息：
```shell
ifconfig
```

显示所有连通中的Socket：
```shell
netstat -a
```

显示网卡列表：
```shell
netstat -i
```

检测是否与`<url_name>`主机连通：
```shell
ping <url_name>
```

# 软件管理

管理员权限下载安装某软件：
```shell
sudo apt install <software_name>
```

# 设备管理

关闭计算器并切断电源（系统管理员权限）：
```shell
poweroff
```

- `-n`：在关机前不做将记忆体资料写回硬盘的动作。
- `-w`：并不会真的关机，只是把记录写到`/var/log/wtmp`档案里。
- `-d`：不把记录写到`/var/log/wtmp`文件里。
- `-i`：在关机之前先把所有网络相关的装置先停止。
- `-p`：关闭操作系统之前将系统中所有的硬件设置为备用模式。

## 显卡管理

查看NVIDIA显卡驱动版本：
```shell
cat /proc/driver/nvidia/version
```

查看NVIDIA显卡占用情况：
```shell
nvidia-smi
```

查询所有NVIDIA显卡：
```shell
lspci | grep -i nvidia
```

查看显卡`<gc_id>`具体属性：
```shell
lspci -v -s <gc_id>
```

# 系统管理

显示操作系统全部信息（包括内核名称、主机名、操作系统版本、处理器类型和硬件架构等）：
```shell
uname -a
```

显示当前时间：
```shell
date
```

清除屏幕：
```shell
clear
```

# 补充说明

1. 自动提示补全文件或文件夹名称：按`Tab`键。
2. 通过ssh连接远程服务器：`ssh -i <your_rsa_path> <your_username>@<server_ip> -p <server_port>`。
3. `>`表示写入流，会覆盖；`>>`也表示写入流，会追加。
4. 把标准报错也作为标准输出：`2>&1`。
5. 当前目录用`.`表示，当前目录的父目录用`..`表示，当前用户的根目录`/home/<username>`用`~`表示，根目录则是`/`。
6. 执行当前目录下可执行文件`<file_name>`：
    ```shell
    ./<file_name>
    ```

