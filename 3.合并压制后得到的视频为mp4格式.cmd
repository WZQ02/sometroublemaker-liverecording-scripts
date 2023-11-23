@echo off
setlocal enabledelayedexpansion

title 3.�ϲ�ѹ�ƺ�õ�����ƵΪmp4��ʽ

if exist ffpath.cfg (
	for /f "delims=" %%a in (ffpath.cfg) do (set ffpath=%%a) && echo ��ָ�� FFmpeg ��ִ���ļ�·��Ϊ !ffpath!��
	goto :merge
)
where ffmpeg > nul
if %ERRORLEVEL% == 0 (
	set ffpath=ffmpeg && echo ����ʹ���Ѱ�װ�� FFmpeg ����
	goto :merge
)
set /p ffpath=��ָ�� FFmpeg ��ִ���ļ���·������ FFmpeg.exe �ļ�ֱ���Ͻ������س���:
echo !ffpath! > ffpath.cfg

:merge
for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g1)
:g1
echo ��ָ��¼������·��Ϊ %roompath%��

cd /d %roompath%

for %%i in (temp\*_converted.ts) do echo file '%%i' >> tsmerge_filelist.txt
echo ���ڵ����ļ��±������м�飬�Ƿ�Ҫ�ϲ���Щ��Ƶ�ļ�����ȷ��û����󣬱��沢�رռ��±������Լ�����
notepad tsmerge_filelist.txt
echo ���ںϲ�...

set timestamp=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
set outputname=output_%timestamp%.mp4

%ffpath% -f concat -safe 0 -i tsmerge_filelist.txt -c copy %outputname%

if exist %outputname% goto :done
goto :fail

:fail
echo ��Ƶ�ϲ�ʧ�ܣ�������Ҫ���м�鲢�ֶ��ϲ���Ƶ����������˳�...
pause > nul
goto :EOF

:done
del tsmerge_filelist.txt
echo ��������ϲ�ǰ����Ƶ�͵�Ļ�ļ�...
del temp\*_converted.ts
del temp\*-*-*-*.ass

rd temp

echo �ѽ���Ƶ�ϲ�Ϊ %roompath%\%outputname%����������˳�...
pause > nul