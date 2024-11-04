@echo off
set buildDate=%DATE:~4,10%
set buildTime=%time: =0%
set now_mmddyyyy_hhmm=%buildDate:~0,2%%buildDate:~3,2%%buildDate:~6,4%_%buildTime:~0,2%%buildTime:~3,2%%
set commitString=%COMPUTERNAME%_%now_mmddyyyy_hhmm%
git add -A
git commit -m %commitString%
git push origin