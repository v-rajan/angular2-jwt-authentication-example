@echo off
setlocal

:: Configuration
set OPENSSL_IMAGE=alpine/openssl:latest
set KEY_FILE=private.key
set CERT_FILE=certificate.crt
set P12_FILE=keystore.p12
set P12_PASSWORD=MyStrongPassword
set ALIAS=mykey
set WORK_DIR=C:\LTA\code\angular2-jwt-authentication-example

:: Generate private key
echo Generating private key...
podman run --rm -v %WORK_DIR%:/data %OPENSSL_IMAGE% genpkey -algorithm RSA -out /data/%KEY_FILE% -aes256 -pass pass:%P12_PASSWORD%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:: Generate CSR (Certificate Signing Request)
echo Generating CSR...
podman run --rm -v %WORK_DIR%:/data %OPENSSL_IMAGE% req -new -key /data/%KEY_FILE% -out /data/request.csr -passin pass:%P12_PASSWORD% -subj "/CN=example.com"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:: Self-sign the certificate (valid for 1 year)
echo Generating self-signed certificate...
podman run --rm -v %WORK_DIR%:/data %OPENSSL_IMAGE% x509 -req -days 365 -in /data/request.csr -signkey /data/%KEY_FILE% -out /data/%CERT_FILE% -passin pass:%P12_PASSWORD%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:: Generate PKCS#12 (.p12) file
echo Generating PKCS#12 keystore...
podman run --rm -v %WORK_DIR%:/data %OPENSSL_IMAGE% pkcs12 -export -out /data/%P12_FILE% -inkey /data/%KEY_FILE% -in /data/%CERT_FILE% -passin pass:%P12_PASSWORD% -passout pass:%P12_PASSWORD% -name %ALIAS%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo PKCS#12 file created successfully: %P12_FILE%
endlocal
