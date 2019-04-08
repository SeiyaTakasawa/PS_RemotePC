"指定したアプリケーションを遠隔で起動します"

$currentPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $currentPath

# セッション開始
$beginSessionPath = $currentPath + "\BeginSession.ps1"
Write-Host "Begin Session path = " $beginSessionPath 
#powershell $beginSessionPath

# _Setting.txtを読み込む

$settingPath = $currentPath + "\_Settings.csv"
$settingCSV = Import-Csv $settingPath -Encoding Default
$Process = ($settingCSV | Where-Object{$_.Key -eq "Process"})[0].Value

Write-Host ("起動ファイルパス : " + $RunPath )


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

"--------------------------------実行開始--------------------------------"

# 実行
if($Process.Length -gt 0){
    for($i = 0; $i -lt $num; $i++){
       $ip = $arrayIPs[$i]
       $ping = Test-Connection $ip -Count 1 -Quiet
       if($ping){
           $strDataPath = "\\" + $ip + "\\" + $arrayFolders[$i] + "\\" + $Process
           if(test-path $strDataPath){
            Write-Host ($strDataPath + 'を実行します')
            $ipname = "\\" +  $ip

            PsExec.exe -i -d -s -u $arrayUsers[$i] -p $arrayPWs[$i] $ipname $strDataPath
           }else{
            Write-Host ($strDataPath + 'は存在しませんでした')
           }
        }else{
          Write-Host ($ip + 'に接続できませんでした') 
        }  
    }

}else{
   "Error : _Setting.csvに適切なPathがありません"
}

# セッション終了
$endSessionPath = $currentPath + "\\EndSession.ps1"
#powershell $endSessionPath

"--------------------------------実行終了--------------------------------"


