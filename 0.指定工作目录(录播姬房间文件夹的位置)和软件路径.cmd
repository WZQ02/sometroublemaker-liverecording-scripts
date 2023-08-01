@echo off
setlocal enabledelayedexpansion

title 0.指定工作目录(录播姬房间文件夹的位置)和软件路径

if not exist path.cfg (
set /p dmfpath=请指定 DanmakuFactory CLI 软件的路径（把 DanmakuFactory_***CLI.exe 文件直接拖进来并回车）:
echo !dmfpath! > path.cfg
)
for /f "delims=" %%a in (path.cfg) do (set dmfpath=%%a && goto :g1)
:g1
echo 已指定 DanmakuFactory 软件路径为 %dmfpath%。

set /p roompath=请指定录播姬房间文件夹的路径（把路径复制过来回车）：
(echo %dmfpath%
echo %roompath%) > path.cfg
echo 已指定录播房间路径为 %roompath%。
echo 已完成初步设置。

ping localhost -n 4 > nul
start 1.1使用DanmakuFactory转换弹幕.cmd
echo 现在可关闭本窗口。