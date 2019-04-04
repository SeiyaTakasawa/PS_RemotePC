# PS_RemotePC

## Overview

制御用PCから複数台のPCを管理するPowerShell  

・フォルダを同期する  
・アプリケーションを起動する  
・アプリケーションを終了する  
・起動しているタスクを確認する  

## Description

RemoteSync.ps1 : 指定したフォルダを同期する


## Usage

(1) _SessionList.csvにPCを登録する

登録は二行目から

左からIPアドレス、ユーザー名、パスワード、共有フォルダ名

``` _SessionList.csv
IP,User,PW,Folder
192.168.1.101,Test_0,password,ShareTest
192.168.1.102,Test_1,password,ShareTest

```

(2) _Settings.csvを設定する

|Key|Value|
|:---:|:---:|
|SyncSrc|同期元フォルダパス|
|SyncDst|同期先フォルダパス|

※同期先フォルダが存在しない場合は自動的に作成されます


``` _Settings.csv
Key,Value
SyncSrc,C:\SyncTest
SyncDst,SyncTest

```


(3) 実行する  

ps1ファイルを右クリック > PowerShellで実行

<details><summary> コマンドから実行する（実行権限なし）</summary><div>

管理者権限でExecutionPolicyを変更できない場合

``` 
powershell -ExecutionPolicy RemoteSigned -File RemoteWakeUp.ps1
```

</div></details>

<details><summary> コマンドから実行する（実行権限あり）</summary><div>


``` 
powershell -File RemoteWakeUp.ps1
```

</div></details>

<details><summary> ショートカットを作成する</summary><div>

(1) ps1ファイルを右クリックしてショートカットを作成する

(2) ショートカットを右クリックしてプロパティを開く

(3) リンク先(T):を変更する

``` 
powershell -ExecutionPolicy RemoteSigned -File [path]
```

※[path]にはps1ファイルのpathを入力する

</div></details>

## Settings

<details><summary>実行権限を与える</summary><div>

(1) powershellを管理者として実行する  

(2) RemoteSignedをSetする

``` 
Set-ExecutionPolicy RemoteSigned
```

(3) yを入力してEnter

</div></details>