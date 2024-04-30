@echo off
::截取年月日
set ymd=%date:~0,4%-%date:~5,2%-%date:~8,2%,

::截取时分秒
set hms=%time:~0,2%:%time:~3,2%:%time:~6,2%

::rem 或者 set hms=%time:~-11,2%%time:~-8,2%%time:~-5,2%%time:~-2,2%

set dt=%ymd%%hms%
::输出
echo %dt%

@echo on