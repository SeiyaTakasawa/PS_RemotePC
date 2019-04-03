
function MakePSCredential( $ID, $PlainPassword ){
    $SecurePassword = ConvertTo-SecureString –String $PlainPassword –AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential($ID, $SecurePassword)
    Return $Credential
}


# Current移動
$currentPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $currentPath

# _Setting.txtを読み込む
$settingPath = $currentPath + "\_Settings.csv"
$settingCSV = Import-Csv $settingPath -Encoding Default
#$runPath = ($settingCSV | Where-Object{$_.Key -eq "RunPath"})[0].Value

# _SessionList.csvを読み込みます
$currentPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $currentPath
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


# Stop-Process

for($i = 0; $i -lt $num; $i++){ 
   $ping = Test-Connection $arrayIPs[$i] -Count 1 -Quiet

   if($ping){

    $Credential = MakePSCredential $arrayUsers[$i] $arrayPWs[$i]
    
   
    Invoke-Command -ComputerName $arrayIPs[$i] -Credential $Credential -ScriptBlock { Get-Process -IncludeUserName | Where-Object -FilterScript {($_.UserName -match "PS_")} }


   }

}


pause