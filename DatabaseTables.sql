
USE Zurrapa
--

-- Criar as tabelas


if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Empregado]') )
begin
  CREATE TABLE Empregado (
	  IDEmpregado int NOT NULL 
	     CHECK (IDEmpregado >= 1),                    -- constraint type: check
    Nome nvarchar(30) NOT NULL, 
    Funcao nvarchar(30) NOT NULL, 
    Endereco nvarchar(30) NOT NULL
      DEFAULT 'Covilha',                      -- Default definition
    
    CONSTRAINT PK_IDEmpregado PRIMARY KEY (IDEmpregado), -- constraint type: primary key       
  ); 
    
end


-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Local]') )
begin
  CREATE TABLE Local (
	  IDLocal int NOT NULL
               CHECK (IDLocal >= 1),
	  Designacao nvarchar (30) NOT NULL,
      Tipo nvarchar (30) NOT NULL,
          
	  IDEmpregado int NOT NULL 
	     CHECK (IDEmpregado >= 1),

          CONSTRAINT PK_IDLocal PRIMARY KEY (IDLocal), -- constraint type: primary key  
  );
end

-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Deslocacao]') )
begin
  CREATE TABLE Deslocacao (
	  De int NOT NULL,
      Para int NOT NULL,
	  Tempo int NOT NULL,
          
	   CONSTRAINT FK_De FOREIGN KEY (De)
	     REFERENCES Local(IDLocal)
	     ON UPDATE CASCADE,

	   CONSTRAINT FK_Para FOREIGN KEY (Para)
	     REFERENCES Local(IDLocal)
	     ON UPDATE NO ACTION,

          CONSTRAINT PK_Deslocacao PRIMARY KEY (De, Para), -- constraint type: primary key  
  );
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[EscalaTrabalho]') )
begin
  CREATE TABLE EscalaTrabalho (
	  
	  IDEmpregado int NOT NULL
		CHECK (IDEmpregado >= 1),
	  IDLocal int NOT NULL
		CHECK (IDLocal >= 1),
	  Hora nvarchar (50) NOT NULL ,
	  Dia nvarchar (30) NOT NULL ,            -- NULL Column
	  
	  CONSTRAINT FK_IDEmpregado FOREIGN KEY (IDEmpregado)
	     REFERENCES Empregado(IDEmpregado)
	     ON UPDATE CASCADE,
	 
	 
          CONSTRAINT FK_IDLocal FOREIGN KEY (IDLocal) 
	    REFERENCES Local(IDLocal)
	    ON UPDATE CASCADE
  ); 
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Estado_Mesa]') )
begin
  CREATE TABLE Estado_Mesa (
	 
	  Cod_EstadoMesa int NOT NULL,
	  Estado nvarchar (30) NOT NULL ,
	  

		 --CONSTRAINT PK_Mesa PRIMARY KEY (IDLocal,NMesa), -- constraint type: primary key 
	  CONSTRAINT PK_Cod_EstadoMesa PRIMARY KEY (Cod_EstadoMesa),
		
  ); 
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Mesa]') )
begin
  CREATE TABLE Mesa (
	 
	  IDLocal int NOT NULL,
	  IDEmpregado int,
	  N_Mesa int NOT NULL ,            -- NULL Column
	  Cod_EstadoMesa int NOT NULL, 
	  
	  CONSTRAINT FK_IDEmpregado1 FOREIGN KEY (IDEmpregado)
	     REFERENCES Empregado(IDEmpregado)
	     ON UPDATE CASCADE,
	  
	  CONSTRAINT FK_IDLocal1 FOREIGN KEY (IDLocal)
	     REFERENCES Local(IDLocal)
	     ON UPDATE CASCADE,

		CONSTRAINT FK_Cod_EstadoMesa FOREIGN KEY (Cod_EstadoMesa)
	     REFERENCES Estado_Mesa(Cod_EstadoMesa)
	     ON UPDATE CASCADE,

		 --CONSTRAINT PK_Mesa PRIMARY KEY (IDLocal,NMesa), -- constraint type: primary key 
	    CONSTRAINT PK_Mesa PRIMARY KEY (N_Mesa, IDLocal),
		
  ); 
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Estado_Pedido]') )
begin
  CREATE TABLE Estado_Pedido (
	 
	  Cod_EstadoPedido int NOT NULL,
	  Estado nvarchar (30) NOT NULL ,
	  

		 --CONSTRAINT PK_Mesa PRIMARY KEY (IDLocal,NMesa), -- constraint type: primary key 
	  CONSTRAINT PK_Cod_EstadoMesa1 PRIMARY KEY (Cod_EstadoPedido),
		
  ); 
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Pedido]') )
begin
  CREATE TABLE Pedido (

      IDPedido int NOT NULL,
	  Cod_EstadoPedido int NOT NULL,
	  IDLocal int NOT NULL,
	  N_Mesa int NOT NULL , 
	  IDEmpregado int NOT NULL ,
	  Dia nvarchar (30) NOT NULL ,
	  Hora nvarchar (30) NOT NULL ,
	  
	  
	  CONSTRAINT FK_IDEmpregado2 FOREIGN KEY (IDEmpregado)
	     REFERENCES Empregado(IDEmpregado)
	     ON UPDATE CASCADE,
	  
	  CONSTRAINT FK_NMesa FOREIGN KEY (N_Mesa, IDLocal)
	     REFERENCES Mesa(N_Mesa, IDLocal)
	     ON UPDATE NO ACTION,

	  CONSTRAINT FK_Cod_EstadoPedido FOREIGN KEY (Cod_EstadoPedido)
	     REFERENCES Estado_Pedido(Cod_EstadoPedido)
	     ON UPDATE NO ACTION,
	    
	  CONSTRAINT PK_IDPedido PRIMARY KEY (IDPedido),
       
  ); 
end

-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Produto]') )
begin
  CREATE TABLE Produto (

	  IDProduto int NOT NULL,
	  Designacao nvarchar (30) NOT NULL,
	  Preco_Compra decimal(5,2) NOT NULL,
	  Preco_Venda decimal(5,2) NOT NULL,
	  
	  CONSTRAINT ID_Produto PRIMARY KEY (IDProduto),
  ); 
end

-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Linha_Pedido]') )
begin
  CREATE TABLE Linha_Pedido(

      IDPedido int NOT NULL,
	  IDProduto int NOT NULL,
	  Qtd_Pedida int,
	  Qtd_Consumida int,
	  Qtd_Paga int,
	  
	  CONSTRAINT FK_IDPedido2 FOREIGN KEY (IDPedido)
	     REFERENCES Pedido(IDPedido)
	     ON UPDATE CASCADE,
      
	  CONSTRAINT FK_IDProduto FOREIGN KEY (IDProduto)
	     REFERENCES Produto(IDProduto)
	     ON UPDATE CASCADE,

	 CONSTRAINT PK_Linha_Pedido PRIMARY KEY (IDPedido,IDProduto),
  ); 
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Unidade_Medida]') )
begin
  CREATE TABLE Unidade_Medida (
      
	  Codigo_Unid int NOT NULL,
	  Designacao nvarchar (30) NOT NULL,
	  Unidade int NOT NULL,
	  
	  CONSTRAINT PK_Codigo_Unid PRIMARY KEY (Codigo_Unid),
  ); 
end
-- ............................................................................
if not exists (select * from dbo.sysobjects 
               where id = object_id(N'[dbo].[Stock]') )
begin
  CREATE TABLE Stock (
      
	  IDLocal int NOT NULL,
	  IDProduto int NOT NULL,
	  Qtd int,
	  Codigo_Unid int NOT NULL,
	  
	  CONSTRAINT FK_IDLocal2 FOREIGN KEY (IDLocal)
	     REFERENCES Local(IDLocal)
	     ON UPDATE CASCADE,
      
	  CONSTRAINT FK_IDProduto1 FOREIGN KEY (IDProduto)
	     REFERENCES Produto(IDProduto)
	     ON UPDATE CASCADE,

	  CONSTRAINT FK_Codigo_Unid FOREIGN KEY (Codigo_Unid)
	     REFERENCES Unidade_Medida(Codigo_Unid)
	     ON UPDATE CASCADE,
  ); 
end




