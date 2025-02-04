@echo off
TITLE Purge 실행기
echo 관리자 권한으로 실행해주세요!
echo.

wmic diskdrive get Index, Model, SerialNumber

REM pushd %~dp0
set /p drive=Purge를 원하는 드라이브의 Index를 입력하세요: 
echo sel disk %drive% > command.txt
echo detail disk >> command.txt
echo exit >> command.txt

diskpart /s command.txt > result.txt

echo ========================================================
type result.txt
echo ========================================================
echo.

set /p q1=이 드라이브가 선택한 드라이브가 맞습니까? [y/n] 
if "%q1%" == "y" ( goto q1_yes )else (
	echo.
	echo 선택한 드라이브와 다른 드라이브가 출력된다면 Diskpart의 list disk 명령어를 이용해주세요.
	goto quit
)
	
:q1_yes
echo.
set /p q2=해당 드라이브를 Purge 하시겠습니까? [y/n] 
if "%q2%" == "y" ( goto q2_yes )else ( goto quit )

:q2_yes
echo.
set /p q3=모든 데이터가 사라지게 됩니다. 확인하셨습니까? [y/n] 
if "%q3%" == "y" (
	echo.
	echo Purge를 진행합니다. 
	echo sel disk %drive% > command.txt
	echo clean all >> command.txt
	echo exit >> command.txt
	diskpart /s command.txt
)else (goto quit)
 

:quit
echo.
del command.txt
del result.txt
pause