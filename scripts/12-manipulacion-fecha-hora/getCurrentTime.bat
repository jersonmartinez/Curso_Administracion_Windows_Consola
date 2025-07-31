@echo off
title Get Current Time

:getCurrentTime
    echo The current time is: %time:~0,8%
    timeout 1 > NUL
    cls
goto :getCurrentTime

pause>nul
exit 