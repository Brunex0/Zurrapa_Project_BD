
USE master
---Create the DataBase

IF ( EXISTS( SELECT * FROM [dbo].[sysdatabases] Where name = 'Zurrapa') )
Begin
  DROP DATABASE Zurrapa
end


IF (NOT EXISTS( SELECT * FROM [dbo].[sysdatabases] Where name = 'Zurrapa') )
Begin


  CREATE DATABASE Zurrapa
  ON 
   ( NAME = 'Projecto_dat',
    
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Projdat.mdf',
      
      SIZE = 10,
      MAXSIZE = 50,
      FILEGROWTH = 5 )
   LOG ON
   ( NAME = 'Projecto_log',
   
   FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Projlog.ldf',

     SIZE = 5MB,
     MAXSIZE = 25MB,
     FILEGROWTH = 5MB )
end