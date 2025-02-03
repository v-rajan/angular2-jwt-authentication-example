@echo off
setlocal

:: Configuration
set OPENSSL=openssl
set KEY_FILE=private.key
set CERT_FILE=certificate.crt
set P12_FILE=keystore.p12
set P12_PASSWORD=MyStrongPassword
set ALIAS=mykey

:: Generate private key
echo Generating private key...
%OPENSSL% genpkey -algorithm RSA -out %KEY_FILE% -aes256 -pass pass:%P12_PASSWORD%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:: Generate CSR (Certificate Signing Request)
echo Generating CSR...
%OPENSSL% req -new -key %KEY_FILE% -out request.csr -passin pass:%P12_PASSWORD% -subj "/CN=example.com"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:: Self-sign the certificate (valid for 1 year)
echo Generating self-signed certificate...
%OPENSSL% x509 -req -days 365 -in request.csr -signkey %KEY_FILE% -out %CERT_FILE% -passin pass:%P12_PASSWORD%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

:: Generate PKCS#12 (.p12) file
echo Generating PKCS#12 keystore...
%OPENSSL% pkcs12 -export -out %P12_FILE% -inkey %KEY_FILE% -in %CERT_FILE% -passin pass:%P12_PASSWORD% -passout pass:%P12_PASSWORD% -name %ALIAS%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

echo PKCS#12 file created successfully: %P12_FILE%
endlocal
