# Steps for setting up SQL Server 2019 Linux container 

## Pull SQL Server 2019 Linux image

```code

docker pull mcr.microsoft.com/mssql/server:2019-latest

```

## Run SQL Server container

```code

docker run -e "ACCEPT_EULA=Y" `
 -e "SA_PASSWORD=May@2021" `
   -p 1433:1433 `
   --name sql1 `
   -h sql1 `
   -d mcr.microsoft.com/mssql/server:2019-latest
   
```