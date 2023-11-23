@echo off
setlocal enabledelayedexpansion

title 3.合并压制后得到的视频为mp4格式

if exist ffpath.cfg (
	for /f "delims=" %%a in (ffpath.cfg) do (set ffpath=%%a) && echo 已指定 FFmpeg 可执行文件路径为 !ffpath!。
	goto :merge
)
where ffmpeg > nul
if %ERRORLEVEL% == 0 (
	set ffpath=ffmpeg && echo 正在使用已安装的 FFmpeg 程序。
	goto :merge
)
set /p ffpath=请指定 FFmpeg 可执行文件的路径（把 FFmpeg.exe 文件直接拖进来并回车）:
echo !ffpath! > ffpath.cfg

:merge
for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g1)
:g1
echo 已指定录播房间路径为 %roompath%。

cd /d %roompath%

for %%i in (temp\*_converted.ts) do echo file '%%i' >> tsmerge_filelist.txt
echo 请在弹出的记事本窗口中检查，是否要合并这些视频文件？（确认没问题后，保存并关闭记事本窗口以继续）
notepad tsmerge_filelist.txt
echo 正在合并...

set timestamp=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
set outputname=output_%timestamp%.mp4

%ffpath% -f concat -safe 0 -i tsmerge_filelist.txt -c copy %outputname%

if exist %outputname% goto :done
goto :fail

:fail
echo 视频合并失败，您将需要自行检查并手动合并视频。按任意键退出...
pause > nul
goto :EOF

:done
del tsmerge_filelist.txt
echo 正在清除合并前的视频和弹幕文件...
del temp\*_converted.ts
del temp\*-*-*-*.ass

rd temp

echo 已将视频合并为 %roompath%\%outputname%。按任意键退出...
pause > nul