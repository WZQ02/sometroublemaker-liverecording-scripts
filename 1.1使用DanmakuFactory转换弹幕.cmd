@echo off
setlocal enabledelayedexpansion

if not exist path.cfg (
	echo ��δָ������ͷ���·����
	ping localhost -n 4 > nul
	start cmd /c "0.ָ������Ŀ¼^(¼���������ļ��е�λ��^)�����·��.cmd"
	goto :EOF
)

set script_path=%cd%
title 1.1ʹ��DanmakuFactoryת����Ļ

for /f "delims=" %%a in (path.cfg) do (set dmfpath=%%a && goto :g1)
:g1
echo ��ָ�� DanmakuFactory ���·��Ϊ %dmfpath%

for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g2)
:g2
echo ��ָ��¼������·��Ϊ %roompath%

if not exist danmaku.cfg (
	goto :configure
)
set /a num1=0
for /f "delims=" %%a in (danmaku.cfg) do (set /a num1=num1+1 && set dmsetting!num1!=%%a)
if %dmsetting2%==n (
	set msg1=����ʾ��Ļ�������û���
) else (
	set msg1=��ʾ��Ļ�������û���
)
set /p ask1=�Ƿ�ʹ���ϴε����ã�����Ļ�����С��%dmsetting1%��%msg1%��������ĸ N �Ը������ã��򰴻س�����...��
if /i "%ask1%"=="N" goto :configure
goto :convert_danmaku

:configure
set dmsetting1=50
set /p dmsetting1=��ָ����Ļ�������С��Ĭ��Ϊ 50������ȷ����ֱ�ӻس��Լ�������
set dmsetting2=n
set /p dmsetting2=�Ƿ���ʾ��Ļ�������û�����Ĭ��Ϊ����ʾ�����������ַ����س�������Ϊ��ʾ����
(echo %dmsetting1%
echo %dmsetting2%) > danmaku.cfg

:convert_danmaku
cd %roompath%
echo ��������ת���÷���ĵ�Ļ�ļ�...
if %dmsetting2%==n (
	for %%i in (¼��-*.xml) do %dmfpath% -o ass "%%i.ass" -i "%%i" -r 1920x1080 -S %dmsetting1% -D 0 -L 2
) else (
	for %%i in (¼��-*.xml) do %dmfpath% -o ass "%%i.ass" -i "%%i" -r 1920x1080 -S %dmsetting1% -D 0 -L 2 --showusernames true
)
for %%i in (¼��-*.xml.ass) do (set af="%%i" && move /y "%%i" !af:~0,-10!.ass)

echo ����ɵ�Ļ�ļ�ת����
ping localhost -n 4 > nul

cd %script_path%
start cmd /c "1.2^(��ѡ^)���ĵ�Ļ������ʽ.cmd"
echo ���ڿɹرձ����ڡ�