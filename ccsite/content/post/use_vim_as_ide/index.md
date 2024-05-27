---
title: "Vim配置为IDE之踩坑记录"
description: 
date: 2024-05-27T21:59:05+08:00
image: 
math: 
license: 

hidden: false
comments: true
draft: false



categories:
- 开发工具

---

## 前言

这篇博文是[use_vim_as_ide](https://github.com/yangyangwithgnu/use_vim_as_ide)这个教程的实际实践记录，主要记录自己在按照该教程进行vim配置时遇到的问题以及解决方法。

## 虚拟机ubuntu设置代理

### 问题

由于我的vim配置是在虚拟机ubuntu20.04上完成的，因此通过git拉取仓库代码也需要直接在虚拟机内操作。遇到的问题是，虽然我的主机使用了代理软件，但是在虚拟机内访问git的速度还是很慢甚至无法访问。

### 解决方法

参考[虚拟机 ubuntu 20.04 git 设置代理的方法_ubuntu git代理-CSDN博客](https://blog.csdn.net/tcjy1000/article/details/137356852)来进行虚拟机的代理配置。

在主机上，我使用了代理软件Clash for Windows，在常规页面可以查到端口为7890，这个端口号就是代理软件运行的端口号。

在主机windows系统下使用`ipconfig`获取主机ip地址，假设主机ip地址为`192.168.0.1`，那么对于虚拟机ubuntu来说，其代理地址就是`192.168.0.1:7890`。



在虚拟机上，git设置代理的命令为

```shell
git config --global https.proxy https://192.168.0.1:7890
git config --global http.proxy http://192.168.0.1:7890
```

设置后，即可通过代理来进行git仓库代码拉取。



## Vim的源码安装以及插件管理

### 问题

根据[use_vim_as_ide](https://github.com/yangyangwithgnu/use_vim_as_ide)教程所说，为了使用未被功能阉割的vim全功能最新版，需要通过git来拉取最新仓库代码进行编译安装，具体操作按教程来就行，我的问题在于python的配置。

主要有以下几个问题：

1. python2.7目录下没有config目录。

2. vundle的.vimrc配置信息有错误。

3. 正确配置了python2.7和python3，并且安装插件以后，在vim执行遇到问题` YouCompleteMe unavailable: unable to load Python`。

### 解决方式

#### 通过安装python2.7-dev包来获取python-config

虽然在ubuntu系统上已经安装了python2.7，但是通常情况下python2.7的配置文件python-config不会自动安装。因此需要在ubuntu上安装python2.7-dev包：

```shell
sudo apt-get update
sudo apt-get install python2.7-dev
```

然后，一般情况下便可在/usr/lib/python2.7下找到`config-x86_64-linux-gnu`。如此便可以正确填入vim的./configure有关python的配置信息了，我的是：

```shell
./configure --with-features=huge --enable-python3interp --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu/ --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ --enable-gui=gtk2 --enable-cscope --prefix=/usr
```

其中和python相关的是：

```
--enable-python3interp
--enable-pythoninterp
--with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu/
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/
```

之后`make && make install` 成功安装vim以后，可以通过`vim --version|grep python`的命令来查看vim对python的支持情况为“+python/dyn”和“+python3/dyn”,表示成功安装了python。



#### 修改vundle的配置信息

将[use_vim_as_ide](https://github.com/yangyangwithgnu/use_vim_as_ide)教程里的vundle的配置信息写入.vimrc文件执行后会遇到有关语法错误的报错信息。为了解决这一问题，需要在有关vundle的配置信息前增加一句话：

```
set nocompatible
```

这句话的作用是使Vim不使用vi兼容模式，而是使用Vim正常模式。因为Vim的脚本语言和插件系统需要Vim处于非兼容模式才能正常工作。



#### 重新配置vim的python版本

在配置了.vimrc的vundle相关信息并在vim里执行`:PluginInstall`命令来安装好插件后，启动vim会遇到问题`YouCompleteMe unavailable: unable to load Python`,我的解决方法参考了[linux - YouCompleteMe unavailable: unable to load Python - Stack Overflow](https://stackoverflow.com/questions/61240101/youcompleteme-unavailable-unable-to-load-python)和[Vim compiled with Python support but can&#39;t see sys version - Stack Overflow](https://stackoverflow.com/questions/23023783/vim-compiled-with-python-support-but-cant-see-sys-version)两个网页的内容。

详细来说，`YouCompleteMe`插件从2020年起不再支持python2，因此需要用python3来对其进行编译。

但是在vim通过命令`:python import sys; print(sys.version)` 查看vim使用哪个版本的python时又遇到报错如下：

```python
E448: Could not load library function _PyArg_Parse_SizeT  
E263: Sorry, this command is disabled, the Python library could not be loaded.`
```

原因是基于ubuntu的Debian系统，无法同时加载两个python库。因此考虑到`YouCompleteMe`插件需要通过python3版本进行编译，所以我重新进入git clone下来的vim目录，将./configure去掉了python2相关，重新执行该命令并进行make和make install。之后通过`vim --version|grep python`的命令来查看vim对python的支持情况为“-python/”和“+python3”，则当前vim只支持python3。

之后在启动vim时便不会有`YouCompleteMe unavailable: unable to load Python`这一错误，但是启动vim时会有错误`YCM error. The ycmd server SHUT DOWN (restart wit...the instructions in the documentation`。解决方法参考链接[vim - YCM error. The ycmd server SHUT DOWN (restart wit...the instructions in the documentation - Stack Overflow](https://stackoverflow.com/questions/47667119/ycm-error-the-ycmd-server-shut-down-restart-wit-the-instructions-in-the-docu)，具体为进入`~.vim/bundle/YouCompleteMe`目录并运行 `python install.py`命令。



到此为止该章节遇到的问题均已解决。