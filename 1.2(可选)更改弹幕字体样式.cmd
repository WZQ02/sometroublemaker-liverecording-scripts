@echo off
setlocal enabledelayedexpansion

set script_path=%cd%
title 1.2(可选)更改弹幕字体样式

where pwsh > nul
if %ERRORLEVEL% == 1 (
	rem echo 本批处理用到了新版 Powershell 的语法（因为 cmd 里面批量更改文本内容不方便），但你似乎未安装新版 Powershell。请前往 https://aka.ms/PSWindows 安装它...
	echo 检测到未安装新版 Powershell。将跳过这一步骤...
	ping localhost -n 4 > nul
	start 2.批量压制弹幕到视频.cmd
	goto :EOF
)

for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g1)
:g1
echo 已指定录播房间路径为 %roompath%
cd %roompath%

:ask1
echo 需要将弹幕转换为什么样式？
echo 1. 仅将用户名字体大小缩小为 40 字号（要求上一步转换弹幕时，启用用户名显示，且字体使用默认的 50 字号）
echo 2. 缩小用户名字体，同时把字体描边改成投影，用户名字体改为思源黑体，弹幕字体改为黑体（要求上一步转换弹幕时，启用用户名显示，且字体使用默认的 50 字号，同时你需要已经安装思源黑体字体）
set /p style=指定：
if "%style%"=="1" goto :alter1
if "%style%"=="2" goto :alter2
goto :ask1

:alter1
set strOld1=\c^&H
set strNew1=\fs50\c^&H
set strOld2=\fs50\c^&HBCACF7
set strNew2=\fs40\c^&HBCACF7
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld1%', '%strNew1%') | Out-File %%i -encoding utf8")
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld2%', '%strNew2%') | Out-File %%i -encoding utf8")
goto :end

:alter2
set style1=Microsoft YaHei,50
set strRemove1=\fs50
set strOld1=\move(
set strOld2=:\h{\c^&
set strOld3={\pos(960
set strOld4=:{\c^&
set stylen1=思源黑体 CN Medium,40
set strNew1=\blur1\3c^&H000000^&\3a^&H7F^&\move(
set strNew2=:\h{\fn黑体\b1\c^&
set strNew3={\blur1\3c^&H000000^&\3a^&H7F^&\pos(960
set strNew4=:\h{\fn黑体\b1\c^&
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%style1%', '%stylen1%') | Out-File %%i -encoding utf8")
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strRemove1%', '') | Out-File %%i -encoding utf8")
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld1%', '%strNew1%') | Out-File %%i -encoding utf8")
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld2%', '%strNew2%') | Out-File %%i -encoding utf8")
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld3%', '%strNew3%') | Out-File %%i -encoding utf8")
for %%i in (录制-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld4%', '%strNew4%') | Out-File %%i -encoding utf8")

:end
echo 已更改弹幕字体样式。
ping localhost -n 4 > nul

cd %script_path%
start 2.批量压制弹幕到视频.cmd
echo 现在可关闭本窗口。
