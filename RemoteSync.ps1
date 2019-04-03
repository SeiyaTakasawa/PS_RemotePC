<#
 共有フォルダの同期用スクリプトです
 CopyにはCopy-Itemではなくrobocopyを採用しています
 これは同期先の構成で結果がぶれる事を防ぐ為です
#>
"--------------------------------共有フォルダを同期します--------------------------------"
$src = ""
$strFolderName = "RemoteSync"

$currentPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $currentPath

# セッション開始
$beginSessionPath = $currentPath + "\BeginSession.ps1"
Write-Host "Begin Session path = " $beginSessionPath 
powershell $beginSessionPath

# _Setting.txtを読み込む

$settingPath = $currentPath + "\_Settings.csv"
$settingCSV = Import-Csv $settingPath -Encoding Default
$src = ($settingCSV | Where-Object{$_.Key -eq "SyncSrc"})[0].Value
$strFolderName = ($settingCSV | Where-Object{$_.Key -eq "SyncDst"})[0].Value

Write-Host ("同期元" + $src )
Write-Host ("同期先フォルダ" + $strFolderName )

# _SessionList.csvを読み込みます
$sessionListPath = $currentPath + "\_SessionList.csv"
$sessionListCSV = Import-Csv $sessionListPath -Encoding Default #セッションリスト

# データ配列を作る
$arrayIPs = @()
$arrayUsers = @()
$arrayPWs = @()
$arrayFolders = @()
$sessionListCSV | ForEach-Object{
    $arrayIPs += $_.IP
    $arrayUsers += $_.User
    $arrayPWs += $_.PW
    $arrayFolders += $_.Folder
}

$num = $arrayIPs.length

"--------------------------------同期開始--------------------------------"

# 同期
if($src.Length -gt 0){
    for($i = 0; $i -lt $num; $i++){
       $ip = $arrayIPs[$i]
       $ping = Test-Connection $ip -Count 1 -Quiet
       if($ping){
           $strDataPath = "\\" + $ip + "\\" + $arrayFolders[$i] + "\" + $strFolderName
           if(! (test-path $strDataPath)){
              New-Item $strDataPath -type directory
               Write-Host ($strDataPath + 'を作成しました')
           }

           Write-Host ("同期先" + $strDataPath )
           robocopy $src $strDataPath /MIR

        }  
    }
    "同期終了"

}else{
   "Error : _Setting.csvに適切なPathがありません"
}
pause