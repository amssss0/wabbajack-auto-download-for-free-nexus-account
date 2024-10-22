rmdir /q/s D:\wabbajack\build\app
rmdir /q/s D:\wabbajack\build\launcher

python scripts\version_extract.py > VERSION.txt
SET /p VERSION=<VERSION.txt
mkdir D:\wabbajack\build

dotnet clean
dotnet publish Wabbajack.App.Wpf\Wabbajack.App.Wpf.csproj --framework "net8.0-windows" --runtime win-x64 --configuration Release /p:Platform=x64 -o D:\wabbajack\build\app /p:IncludeNativeLibrariesForSelfExtract=true --self-contained  /p:DebugType=embedded 
dotnet publish Wabbajack.Launcher\Wabbajack.Launcher.csproj --framework "net8.0-windows" --runtime win-x64 --configuration Release /p:Platform=x64 -o D:\wabbajack\build\launcher /p:PublishSingleFile=true /p:PublishSingleFile=true /p:IncludeNativeLibrariesForSelfExtract=true --self-contained  /p:DebugType=embedded
dotnet publish c:\oss\Wabbajack\Wabbajack.CLI\Wabbajack.CLI.csproj --framework "net8.0-windows" --runtime win-x64 --configuration Release /p:Platform=x64 -o D:\wabbajack\build\app\cli  /p:IncludeNativeLibrariesForSelfExtract=true --self-contained  /p:DebugType=embedded
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\signtool.exe" sign /fd sha256 /tr http://ts.ssl.com /td sha256 /sha1 8c26a8e0bf3e70eb89721cc4d86a87137153ccba D:\wabbajack\build\app\Wabbajack.exe
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\signtool.exe" sign /fd sha256 /tr http://ts.ssl.com /td sha256 /sha1 8c26a8e0bf3e70eb89721cc4d86a87137153ccba D:\wabbajack\build\launcher\Wabbajack.exe
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\signtool.exe" sign /fd sha256 /tr http://ts.ssl.com /td sha256 /sha1 8c26a8e0bf3e70eb89721cc4d86a87137153ccba D:\wabbajack\build\app\cli\wabbajack-cli.exe
"c:\Program Files\7-Zip\7z.exe" a c:\tmp\publish-wj\%VERSION%.zip c:\tmp\publish-wj\app\*

copy D:\wabbajack\build\launcher\Wabbajack.exe D:\wabbajack\build\Wabbajack.exe
