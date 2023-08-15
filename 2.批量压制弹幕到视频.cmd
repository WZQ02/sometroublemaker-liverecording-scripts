@echo off
setlocal enabledelayedexpansion

set script_path=%cd%
title 2.批量压制弹幕到视频

if exist ffpath.cfg (
	for /f "delims=" %%a in (ffpath.cfg) do (set ffpath=%%a) && echo 已指定 FFmpeg 可执行文件路径为 !ffpath!。
	goto :con_init
)
where ffmpeg > nul
if %ERRORLEVEL% == 0 (
	set ffpath=ffmpeg && echo 正在使用已安装的 FFmpeg 程序。
	goto :con_init
)
set /p ffpath=请指定 FFmpeg 可执行文件的路径（把 FFmpeg.exe 文件直接拖进来并回车）:
echo !ffpath! > ffpath.cfg

:con_init
if not exist convert.cfg (
	goto :configure
)
set /a num1=0
for /f "delims=" %%a in (convert.cfg) do (set /a num1=num1+1 && set vidsetting!num1!=%%a)
if %vidsetting2%==n (
	set msg1=不二压音频
) else (
	set msg1=二压音频
)
set /p ask1=是否使用上次的设置？（视频编码器：%vidsetting1%，%msg1%，编码参数：%vidsetting3%。输入字母 N 以更改设置，或按回车继续...）
if /i "%ask1%"=="N" goto :configure
goto :convert

:configure
set vidsetting1=libx264
echo 请指定一个视频编码方式（输入对应的数字选择，默认使用 x264）：
echo 1. x264 软件 H.264 视频编码器
echo 2. x265 软件 H.265 视频编码器
echo 3. Intel QuickSync H.264 视频编码器（需要支持 QuickSync 视频编码的 Intel 核显）
echo 4. Intel QuickSync H.265 视频编码器（需要较新的支持 QuickSync 视频编码的 Intel 核显）
echo 5. NVIDIA NVENC H.264 视频编码器（需要支持 NVENC 视频编码功能的 N 卡）
echo 6. NVIDIA NVENC H.265 视频编码器（需要支持 NVENC 视频编码功能的 N 卡）
echo 7. AMD AMF H.264 视频编码器（需要支持 AMF 视频编码功能的 A 卡）
echo 8. AMD AMF H.265 视频编码器（需要支持 AMF 视频编码功能的 A 卡）
echo 9. 指定其他自定义视频编码器...
set /p vsc1=指定：
if "%vsc1%"=="2" set vidsetting1=libx265
if "%vsc1%"=="3" set vidsetting1=h264_qsv
if "%vsc1%"=="4" set vidsetting1=hevc_qsv
if "%vsc1%"=="5" set vidsetting1=h264_nvenc
if "%vsc1%"=="6" set vidsetting1=hevc_nvenc
if "%vsc1%"=="7" set vidsetting1=h264_amf
if "%vsc1%"=="8" set vidsetting1=hevc_amf
if "%vsc1%"=="9" set /p vidsetting1=指定其他的视频编码器（需要是 FFmpeg、TS 和 MP4 封装容器支持的编码格式）：
set vidsetting2=n
set /p vidsetting2=是否二压音频（默认为不二压，输入任意字符并回车则设置为二压音频）：
set vidsetting3=-b:v 4000k
if "%vidsetting1%"=="libx264" set vidsetting3=-crf 21
if "%vsc1%"=="2" set vidsetting3=-crf 23
if "%vsc1%"=="5" set vidsetting3=-qp 24
if "%vsc1%"=="6" set vidsetting3=-qp 24
set /p vidsetting3=是否需要其他自定义音视频编码参数？（不需要则直接回车即可。需要的话在这里加上，如输入 -b:v 6000k -b:a 320k -s 1920x1080 -r 60 则指定视频码率为 6000k，音频码率 320k，并将分辨率和帧率强行设置为 1920x1080 和 60 帧。当前默认参数为%vidsetting3%：）
(echo %vidsetting1%
echo %vidsetting2%
echo %vidsetting3%) > convert.cfg

:convert
for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g1)
:g1
echo 已指定录播房间路径为 %roompath%

cd %roompath%
echo 正在批量压制弹幕到视频...

mkdir temp

for %%i in (录制-*.ass) do (
set r=%%i
copy "%%i" "temp\%%i"
cd temp
ren "%%i" "!r:~3,27!.ass"
cd ..
)

cd temp

if %vidsetting2%==n goto :nocompaudio
for %%i in (..\录制-*.flv) do (
set r=%%i
%ffpath% -i "%%i" -c:v %vidsetting1% -vf "ass=!r:~6,27!.ass" -c:a aac %vidsetting3% "!r:~6,22!_converted.ts"
)
:nocompaudio
for %%i in (..\录制-*.flv) do (
set r=%%i
%ffpath% -i "%%i" -c:v %vidsetting1% -vf "ass=!r:~6,27!.ass" -c:a copy %vidsetting3% "!r:~6,22!_converted.ts"
)

echo 已完成视频转换。
ping localhost -n 4 > nul

cd %script_path%
start 3.合并压制后得到的视频为mp4格式.cmd
echo 现在可关闭本窗口。
