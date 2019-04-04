# PS_RemotePC

## Overview

����pPC���畡�����PC���Ǘ�����PowerShell  

�E�t�H���_�𓯊�����  
�E�A�v���P�[�V�������N������  
�E�A�v���P�[�V�������I������  
�E�N�����Ă���^�X�N���m�F����  

## Description

RemoteSync.ps1 : �w�肵���t�H���_�𓯊�����


## Usage

(1) _SessionList.csv��PC��o�^����

�o�^�͓�s�ڂ���

������IP�A�h���X�A���[�U�[���A�p�X���[�h�A���L�t�H���_��

``` _SessionList.csv
IP,User,PW,Folder
192.168.1.101,Test_0,password,ShareTest
192.168.1.102,Test_1,password,ShareTest

```

(2) _Settings.csv��ݒ肷��

|Key|Value|
|:---:|:---:|
|SyncSrc|�������t�H���_�p�X|
|SyncDst|������t�H���_�p�X|

��������t�H���_�����݂��Ȃ��ꍇ�͎����I�ɍ쐬����܂�


``` _Settings.csv
Key,Value
SyncSrc,C:\SyncTest
SyncDst,SyncTest

```


(3) ���s����  

ps1�t�@�C�����E�N���b�N > PowerShell�Ŏ��s

<details><summary> �R�}���h������s����i���s�����Ȃ��j</summary><div>

�Ǘ��Ҍ�����ExecutionPolicy��ύX�ł��Ȃ��ꍇ

``` 
powershell -ExecutionPolicy RemoteSigned -File RemoteWakeUp.ps1
```

</div></details>

<details><summary> �R�}���h������s����i���s��������j</summary><div>


``` 
powershell -File RemoteWakeUp.ps1
```

</div></details>

<details><summary> �V���[�g�J�b�g���쐬����</summary><div>

(1) ps1�t�@�C�����E�N���b�N���ăV���[�g�J�b�g���쐬����

(2) �V���[�g�J�b�g���E�N���b�N���ăv���p�e�B���J��

(3) �����N��(T):��ύX����

``` 
powershell -ExecutionPolicy RemoteSigned -File [path]
```

��[path]�ɂ�ps1�t�@�C����path����͂���

</div></details>

## Settings

<details><summary>���s������^����</summary><div>

(1) powershell���Ǘ��҂Ƃ��Ď��s����  

(2) RemoteSigned��Set����

``` 
Set-ExecutionPolicy RemoteSigned
```

(3) y����͂���Enter

</div></details>