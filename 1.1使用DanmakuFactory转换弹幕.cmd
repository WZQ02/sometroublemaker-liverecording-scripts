@echo off
setlocal enabledelayedexpansion

if not exist path.cfg (
	echo 尚未指定软件和房间路径！
	ping localhost -n 4 > nul
	start cmd /c "0.指定工作目录^(录播姬房间文件夹的位置^)和软件路径.cmd"
	goto :EOF
)

set script_path=%cd%
title 1.1使用DanmakuFactory转换弹幕

for /f "delims=" %%a in (path.cfg) do (set dmfpath=%%a && goto :g1)
:g1
echo 已指定 DanmakuFactory 软件路径为 %dmfpath%

for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g2)
:g2
echo 已指定录播房间路径为 %roompath%

if not exist danmaku.cfg (
	goto :configure
)
set /a num1=0
for /f "delims=" %%a in (danmaku.cfg) do (set /a num1=num1+1 && set dmsetting!num1!=%%a)
if %dmsetting2%==n (
	set msg1=不显示弹幕发送者用户名
) else (
	set msg1=显示弹幕发送者用户名
)
set /p ask1=是否使用上次的设置？（弹幕字体大小：%dmsetting1%，%msg1%。输入字母 N 以更改设置，或按回车继续...）
if /i "%ask1%"=="N" goto :configure
goto :convert_danmaku

:configure
set dmsetting1=50
set /p dmsetting1=请指定弹幕的字体大小（默认为 50，若不确定则直接回车以继续）：
set dmsetting2=n
set /p dmsetting2=是否显示弹幕发送者用户名（默认为不显示，输入任意字符并回车则设置为显示）：
(echo %dmsetting1%
echo %dmsetting2%) > danmaku.cfg

:convert_danmaku
cd %roompath%
echo 正在批量转换该房间的弹幕文件...
if %dmsetting2%==n (
	for %%i in (录制-*.xml) do %dmfpath% -o ass "%%i.ass" -i "%%i" -r 1920x1080 -S %dmsetting1% -D 0 -L 2
) else (
	for %%i in (录制-*.xml) do %dmfpath% -o ass "%%i.ass" -i "%%i" -r 1920x1080 -S %dmsetting1% -D 0 -L 2 --showusernames true
)
for %%i in (录制-*.xml.ass) do (set af="%%i" && move /y "%%i" !af:~0,-10!.ass)

echo 已完成弹幕文件转换。
ping localhost -n 4 > nul

cd %script_path%
start cmd /c "1.2^(可选^)更改弹幕字体样式.cmd"
echo 现在可关闭本窗口。