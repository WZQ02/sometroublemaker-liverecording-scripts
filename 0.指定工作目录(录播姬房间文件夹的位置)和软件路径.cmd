@echo off
setlocal enabledelayedexpansion

title 0.ָ������Ŀ¼(¼���������ļ��е�λ��)�����·��

if not exist path.cfg (
set /p dmfpath=��ָ�� DanmakuFactory CLI �����·������ DanmakuFactory_***CLI.exe �ļ�ֱ���Ͻ������س���:
echo !dmfpath! > path.cfg
)
for /f "delims=" %%a in (path.cfg) do (set dmfpath=%%a && goto :g1)
:g1
echo ��ָ�� DanmakuFactory ���·��Ϊ %dmfpath%��

set /p roompath=��ָ��¼���������ļ��е�·������·�����ƹ����س�����
(echo %dmfpath%
echo %roompath%) > path.cfg
echo ��ָ��¼������·��Ϊ %roompath%��
echo ����ɳ������á�

ping localhost -n 4 > nul
start 1.1ʹ��DanmakuFactoryת����Ļ.cmd
echo ���ڿɹرձ����ڡ�