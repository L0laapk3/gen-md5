@ECHO OFF
SETLOCAL
if "%~2" NEQ "" set two=y
:loop
set "success="
FOR /F "USEBACKQ" %%i IN (`CertUtil -hashfile "%~1" MD5`) DO (
	if not defined success (
		if "%%i" == "MD5" (
			set success=1
		) else (
			if "%two%" == "y" echo %~1	ERROR
			CertUtil -hashfile "%~1" MD5
			GOTO :done
		)
	) else (
		if "%two%" == "y" echo %%i > "%~1.md5"
		echo %~1	OK
		GOTO :done
	)
)
ENDLOCAL
:done
shift
if not "%~1"=="" goto loop