@echo off
setlocal enabledelayedexpansion

set script_path=%cd%
title 1.2(��ѡ)���ĵ�Ļ������ʽ

where pwsh > nul
if %ERRORLEVEL% == 1 (
	rem echo ���������õ����°� Powershell ���﷨����Ϊ cmd �������������ı����ݲ����㣩�������ƺ�δ��װ�°� Powershell����ǰ�� https://aka.ms/PSWindows ��װ��...
	echo ��⵽δ��װ�°� Powershell����������һ����...
	echo 5 ��������Ƶѹ�� ��������ѹ����Ƶ��ֱ�ӹرձ����ڣ�...
	ping localhost -n 6 > nul
	start 2.����ѹ�Ƶ�Ļ����Ƶ.cmd
	goto :EOF
)

for /f "skip=1 delims=" %%a in (path.cfg) do (set roompath=%%a && goto :g1)
:g1
echo ��ָ��¼������·��Ϊ %roompath%
cd %roompath%

:ask1
echo ��Ҫ����Ļת��Ϊʲô��ʽ��
echo 1. �����û��������С��СΪ 40 �ֺţ�Ҫ����һ��ת����Ļʱ�������û�����ʾ��������ʹ��Ĭ�ϵ� 50 �ֺţ�
echo 2. ��С�û������壬ͬʱ��������߸ĳ�ͶӰ���û��������Ϊ˼Դ���壬��Ļ�����Ϊ���壨Ҫ����һ��ת����Ļʱ�������û�����ʾ��������ʹ��Ĭ�ϵ� 50 �ֺţ�ͬʱ����Ҫ�Ѿ���װ˼Դ�������壩
echo 3. �����ĵ�Ļ��Ļ��ʽ��
set /p style=ָ����
if "%style%"=="1" goto :alter1
if "%style%"=="2" goto :alter2
if "%style%"=="3" echo ����ѡ�񲻸��ĵ�Ļ��ʽ�� && goto :end
goto :ask1

:alter1
set strOld1=\c^&H
set strNew1=\fs50\c^&H
set strOld2=\fs50\c^&HBCACF7
set strNew2=\fs40\c^&HBCACF7
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld1%', '%strNew1%') | Out-File %%i -encoding utf8")
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld2%', '%strNew2%') | Out-File %%i -encoding utf8")
echo �Ѹ��ĵ�Ļ������ʽ��
goto :end

:alter2
set style1=Microsoft YaHei,50
set strRemove1=\fs50
set strOld1=\move(
set strOld2=:\h{\c^&
set strOld3={\pos(960
set strOld4=:{\c^&
set stylen1=˼Դ���� CN Medium,40
set strNew1=\blur1\3c^&H000000^&\3a^&H7F^&\move(
set strNew2=:\h{\fn����\b1\c^&
set strNew3={\blur1\3c^&H000000^&\3a^&H7F^&\pos(960
set strNew4=:\h{\fn����\b1\c^&
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%style1%', '%stylen1%') | Out-File %%i -encoding utf8")
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strRemove1%', '') | Out-File %%i -encoding utf8")
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld1%', '%strNew1%') | Out-File %%i -encoding utf8")
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld2%', '%strNew2%') | Out-File %%i -encoding utf8")
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld3%', '%strNew3%') | Out-File %%i -encoding utf8")
for %%i in (¼��-*.ass) do (pwsh -Command "(gc %%i).replace('%strOld4%', '%strNew4%') | Out-File %%i -encoding utf8")
echo �Ѹ��ĵ�Ļ������ʽ��

:end
echo 5 ��������Ƶѹ�ƣ�������ѹ����Ƶ��ֱ�ӹرձ����ڣ�...
ping localhost -n 6 > nul

cd %script_path%
start 2.����ѹ�Ƶ�Ļ����Ƶ.cmd
echo ���ڿɹرձ����ڡ�
