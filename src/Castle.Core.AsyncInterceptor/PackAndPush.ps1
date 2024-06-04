Write-Host "开始打包.."

dotnet pack --configuration Release
$packages = Get-ChildItem -Path bin/Release -Filter *.nupkg -Recurse
$nugetUrl = "https://api.nuget.org/v3/index.json"

Write-Host "请按下任意键推送包"
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

foreach($package in $packages)
{
	Write-Host '开始发布：'$package.FullName
	dotnet nuget push $package.FullName --skip-duplicate -s $nugetUrl --api-key $env:NugetApiKey
}

Write-Host "Press any key to continue..."  
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
