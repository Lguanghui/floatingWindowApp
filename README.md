# iOS应用内部悬浮窗

## 介绍

本项目能在iOS应用内部生成一个悬浮窗，可用于应用间跳转、浮窗小组件等场景。项目基于UIWindow实现，可以设置浮窗的显示级别、设置浮窗能否被拖离屏幕、浮窗动画等。如下图所示

<img src="./gif/QQ20210912-024735.gif" alt="gif" />

## 环境及依赖
 
 1. 基础环境：Xcode Version 12.5.1，Swift version 5.1.3。项目使用 swift 编写，不含OC
 
 2. 项目使用 [CocoaPods](https://guides.cocoapods.org) 管理第三方库，运行项目前请先执行 `pod install` 安装第三方库，包括 SnipKit、Lookin、Then 等。
