---
title: "Windows上安装Vim"
description: 
date: 2024-05-20T22:48:21+08:00
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

linux自带了vim，但是目前想用vim的话，每次都得开虚拟机才能用linux里的vim。为了练习vim的相关操作，提高使用vim的熟练度，决定在Win系统里也安装上Vim。

## 下载Vim到Win系统

### 方法1

直接打开powershell，输入命令：

```shell
winget install Vim
```

### 方法2

去[Vim官网](https://www.vim.org/download.php#pc) 下载Win系统的安装包，然后点击下载好的exe文件，没有特殊要求的话，一路点击"next"安装即可。

## 配置系统变量

安装好以后可能在powershell里运行vim会提示找不到对应的程序，因此需要配置环境变量。

直接Win+S快捷键，在底下的搜索栏里输入系统变量，选择环境变量->系统变量->Path，点击编辑，将Vim.exe所在目录添加进去，保存。

![](F:\MyBlog\ccsite\static\img\win-path.png)