---
title: "我的建站记录（一）"
description: 
date: 2024-04-25T20:45:59+08:00
lastmod: 2024-04-28
image: cat.jpg
math: 
license: 

hidden: false
comments: true
draft: false



categories:
- 建站记录

---

## 前言

说来惭愧，虽然从上大学开始就是敲代码的，但一直没有自己动手来搭建博客。趁着临近毕业前这段比较空闲的日子，终于开始动手搭博客了。

在进行了相关信息搜集后，最终决定基于[GitHub](https://github.com/)+[Hugo](https://gohugo.io/)搭建博客，采用[Stack ](https://stack.jimmycai.com/)主题。

### 基于GitHub Pages创建个人站点

> [GitHub Pages](https://pages.github.com/)是通过GitHub托管和发布的公共网页。

官方提供的教程为[GitHub Pages 快速入门 - GitHub 文档](https://docs.github.com/zh/pages/quickstart)，完成以后就可以通过username.github.io访问。

教程讲的也比较清晰，下边主要说一下我在创建过程中踩过的坑。

1. 由于长时间没有登录github，在登录github时会发送验证码到注册邮箱，需要将验证码填入才可登录。现在问题来了，我的注册邮箱是QQ邮箱，然而QQ邮箱接收不到github发送来的邮件。
   
   解决方法参考[Github登录用qq邮箱验证无法收到验证码的问题](https://www.bilibili.com/read/cv9269819/)，即把github.com添加到邮箱的域名白名单。
   
   当时我这样做了以后还是收不到邮件，非常抓狂，然后睡了一觉起来后，发现QQ邮箱收到了好几封邮件......
   
   不过之后在github再发送邮件时，就能即时收到了。所以这个问题成功解决。

2. 创建仓库时，仓库名与用户名不同导致无法访问网站。
   
   根据[关于 GitHub Pages - GitHub 文档](https://docs.github.com/zh/pages/getting-started-with-github-pages/about-github-pages)上说的，“若要发布用户站点，必须创建名为 `<username>.github.io` 的个人帐户拥有的存储库。”
   
   解决方法很简单，就是把仓库名改为和用户名一致就行。
   
   另外存个[单个github帐号下添加多个github pages的方法](https://zhuanlan.zhihu.com/p/143298650)，以后尝试一下。

## Hugo

我的操作系统为Win11，下载安装Hugo有几种方法，我选择用包管理器Chocolatey来安装Hugo。

Chocolatey的安装教程为[Chocolatey Software | Installing Chocolatey](https://chocolatey.org/install)，就是通过powershell来安装。

之后执行命令`choco install hugo-extended`来安装Hugo的扩展版。

Hugo安装完成后，就可以使用Hugo快速生成站点：

```shell
hugo new site /path/to/site
```

在/path/to/site文件夹下可以看到网站结构。就不细说了。

## Stack主题

这里需要感谢这个视频[600秒！带小白上手安装使用hugo-stack主题博客_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV15f4y157a6/?spm_id_from=333.1350.jump_directly)，让我最终把stack主题在github pages上呈现出来了。

test