
$currentDirectory = Get-Location
$folderName = Read-Host -Prompt 'Input the folder name'
$folderPath = "$($currentDirectory)\$($folderName)"

$ifFolderIsExist = Test-Path -Path $folderPath

$appFileTemplate = "
import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app: Express = express();
const port = process.env.PORT;

app.get('/', (req: Request, res: Response) => {
    res.send('Express + TypeScript Server');
});

app.listen(port, () => {
    console.log('server is running at port: ' + port);
});
"
$appFilename = "app.ts"

$envFileTemplate = "
PORT=3000
"



if($ifFolderIsExist){
    Write-Output "The folder is exist"
}else{
    Write-Output "Create folder: $($folderName)"
    New-Item -ItemType Directory -Force -Path $folderPath
    
}

Set-Location $folderPath

npm init -y
git init

npm install express dotenv
npm i -D typescript @types/express @types/node
npx tsc --init

New-Item $appFilename
$appFileTemplate | Out-File -FilePath "$($folderPath)/$($appFilename)" -Encoding utf8

New-Item "$($folderPath)/.env"
$envFileTemplate | Out-File -FilePath "$($folderPath)/.env" -Encoding utf8

code .