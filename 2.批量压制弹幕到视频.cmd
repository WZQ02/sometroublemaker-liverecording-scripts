@echo off
setlocal enabledelayedexpansion

set script_path=%cd%
title 2.����ѹ�Ƶ�Ļ����Ƶ

if exist ffpath.cfg (
	for /f "delims=" %%a in (ffpath.cfg) do (set ffpath=%%a) && echo ��ָ�� FFmpeg ��ִ���ļ�·��Ϊ !ffpath!��
	goto :con_init
)
where ffmpeg > nul
if %ERRORLEVEL% == 0 (
	set ffpath=ffmpeg && echo ����ʹ���Ѱ�װ�� FFmpeg ����
	goto :con_init
)
set /p ffpath=��ָ�� FFmpeg ��ִ���ļ���·������ FFmpeg.exe �ļ�ֱ���Ͻ������س���:
echo !ffpath! > ffpath.cfg

:con_init
if not exist convert.cfg (
	goto :configure
)
set /a num1=0
for /f "delims=" %%a in (convert.cfg) do (set /a num1=num1+1 && set vidsetting!num1!=%%a)
if %vidsetting2%==n (
	set msg1=����ѹ��Ƶ
) else (
	set msg1=��ѹ��Ƶ
)
set /p ask1=�Ƿ�ʹ���ϴε����ã�����Ƶ��������%vidsetting1%��%msg1%�����������%vidsetting3%��������ĸ N �Ը������ã��򰴻س�����...��
if /i "%ask1%"=="N" goto :configure
goto :convert

:configure
set vidsetting1=libx264
echo ��ָ��һ����Ƶ���뷽ʽ�������Ӧ������ѡ��Ĭ��ʹ�� x264����
echo 1. x264 ��� H.264 ��Ƶ������
echo 2. x265 ��� H.265 ��Ƶ������
echo 3. Intel QuickSync H.264 ��Ƶ����������Ҫ֧�� QuickSync ��Ƶ����� Intel ���ԣ�
echo 4. Intel QuickSync H.265 ��Ƶ����������Ҫ���µ�֧�� QuickSync ��Ƶ����� Intel ���ԣ�
echo 5. NVIDIA NVENC H.264 ��Ƶ����������Ҫ֧�� NVENC ��Ƶ���빦�ܵ� N ����
echo 6. NVIDIA NVENC H.265 ��Ƶ����������Ҫ֧�� NVENC ��Ƶ���빦�ܵ� N ����
echo 7. AMD AMF H.264 ��Ƶ����������Ҫ֧�� AMF ��Ƶ���빦�ܵ� A ����
echo 8. AMD AMF H.265 ��Ƶ����������Ҫ֧�� AMF ��Ƶ���빦�ܵ� A ����
echo 9. ָ�������Զ�����Ƶ������...
set /p vsc1=ָ����
if "%vsc1%"=="2" set vidsetting1=libx265
if "%vsc1%"=="3" set vidsetting1=h264_qsv
if "%vsc1%"=="4" set vidsetting1=hevc_qsv
if "%vsc1%"=="5" set vidsetting1=h264_nvenc
if "%vsc1%"=="6" set vidsetting1=hevc_nvenc
if "%vsc1%"=="7" set vidsetting1=h264_amf
if "%vsc1%"=="8" set vidsetting1=hevc_amf
if "%vsc1%"=="9" set /p vidsetting1=ָ����������Ƶ����������Ҫ�� FFmpeg��TS �� MP4 ��װ����֧�ֵı����ʽ����
set vidsetting2=n
set /p vidsetting2=�Ƿ��ѹ��Ƶ��Ĭ��Ϊ����ѹ�����������ַ����س�������Ϊ��ѹ��Ƶ����
set vidsetting3=-b:v 4000k
if "%vidsetting1%"=="libx264" set vidsetting3=-crf 21
if "%vsc1%"=="2" set vidsetting3=-crf 23
if "%vsc1%"=="5" set vidsetting3=-qp 24
if "%vsc1%"=="6" set vidsetting3=-qp 24
set /p vidsetting3=�Ƿ���Ҫ�����Զ�������Ƶ���������������Ҫ��ֱ�ӻس����ɡ���Ҫ�Ļ���������ϣ������� -b:v 6000k -b:a 320k -s 1920x1080 -r 60 ��ָ����Ƶ����Ϊ 6000k����Ƶ���� 320k�������ֱ��ʺ�֡��ǿ������Ϊ 1920x1080 �� 60 ֡����ǰĬ�ϲ���Ϊ%vidsetting3%����
(echo %vidsetting1%
echo %vidsetting2%
echo %vidsetting3%) > convert.cfg

:convert
for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g1)
:g1
echo ��ָ��¼������·��Ϊ %roompath%

cd %roompath%
echo ��������ѹ�Ƶ�Ļ����Ƶ...

mkdir temp

for %%i in (¼��-*.ass) do (
set r=%%i
copy "%%i" "temp\%%i"
cd temp
ren "%%i" "!r:~3,27!.ass"
cd ..
)

cd temp

if %vidsetting2%==n goto :nocompaudio
for %%i in (..\¼��-*.flv) do (
set r=%%i
%ffpath% -i "%%i" -c:v %vidsetting1% -vf "ass=!r:~6,27!.ass" -c:a aac %vidsetting3% "!r:~6,22!_converted.ts"
)
:nocompaudio
for %%i in (..\¼��-*.flv) do (
set r=%%i
%ffpath% -i "%%i" -c:v %vidsetting1% -vf "ass=!r:~6,27!.ass" -c:a copy %vidsetting3% "!r:~6,22!_converted.ts"
)

echo �������Ƶת����
ping localhost -n 4 > nul

cd %script_path%
start 3.�ϲ�ѹ�ƺ�õ�����ƵΪmp4��ʽ.cmd
echo ���ڿɹرձ����ڡ�
