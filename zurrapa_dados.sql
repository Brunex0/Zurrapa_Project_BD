
USE Zurrapa
----Empregado----
INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (1, 'Bruno Monteiro', 'Balcao','Covilhã');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (2, 'Manuel Magalhães', 'Mesa','Covilhã');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (3, 'Miguel Pereira', 'Armazem','Covilhã');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (4, 'João Dias', 'Balcao','Fundão');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (5, 'Afonso Rodrigues', 'Mesa','Fundão');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (6, 'Ângela Soares', 'Mesa','Fundão');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (7, 'António Silva', 'Mesa','Fundão');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (8, 'Beatriz Pinto', 'Mesa','Fundão');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (9, 'Joaquim Ferreira', 'Mesa','Fundão');

INSERT INTO Empregado(IDEmpregado,Nome,Funcao,Endereco) 
Values (10, 'Filipe Carvalho', 'Mesa','Fundão');
----*****----

----Local----
INSERT INTO Local(IDLocal,Designacao,IDEmpregado,Tipo)
Values(1,'Bar 6 fase',2,'Bar');

INSERT INTO Local(IDLocal,Designacao,IDEmpregado,Tipo)
Values(2,'Bar 4 fase',1,'Bar');

INSERT INTO Local(IDLocal,Designacao,IDEmpregado,Tipo)
Values(3,'Armazém Central',3,'Armazem');
----*****----
----Deslocacao----
INSERT INTO Deslocacao(De,Para,Tempo)
Values(3,1,35);

INSERT INTO Deslocacao(De,Para,Tempo)
Values(3,2,25);

INSERT INTO Deslocacao(De,Para,Tempo)
Values(1,3,36);

INSERT INTO Deslocacao(De,Para,Tempo)
Values(2,3,24);

INSERT INTO Deslocacao(De,Para,Tempo)
Values(1,2,10);

INSERT INTO Deslocacao(De,Para,Tempo)
Values(2,1,12);
----****----

----EscalaTrabalho----
INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (3,3,'9h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,1,'9h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,2,'9h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,5,'10h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,6,'12h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,7,'13h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,4,'9h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,8,'9h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,9,'9h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,10,'10h','03/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (3,3,'9h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,1,'9h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,2,'9h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,5,'10h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,6,'12h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (1,7,'13h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,4,'9h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,8,'9h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,9,'9h','05/01/2021');

INSERT INTO EscalaTrabalho(IDLocal,IDEmpregado,Hora,Dia) 
Values (2,10,'10h','05/01/2021');
----****----

----Estado_Mesa----
Insert INTO Estado_Mesa(Cod_EstadoMesa, Estado)
values(1, 'Limpa')

Insert INTO Estado_Mesa(Cod_EstadoMesa, Estado)
values(2, 'Ocupada')

Insert INTO Estado_Mesa(Cod_EstadoMesa, Estado)
values(3, 'Suja')
----****----

----Mesa----
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(1,2,1, 2)

INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(1,5,2, 2)					 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(1,5,3, 2)					 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(1,NULL,4, 1)					 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(1,NULL,5, 1)					 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(2,8,1, 3)						 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(2,9,2, 2)						 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(2,10,3, 2)						 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(2,8,4, 2)					 
											 
INSERT INTO Mesa(IDLocal,IDEmpregado,N_Mesa, Cod_EstadoMesa)
Values(2,NULL,5, 1)
----****----

----Estado_Pedido----
INSERT INTO Estado_Pedido(Cod_EstadoPedido,Estado)
Values(1,'Insatisfeito')

INSERT INTO Estado_Pedido(Cod_EstadoPedido,Estado)
Values(2,'Satisfeito')

INSERT INTO Estado_Pedido(Cod_EstadoPedido,Estado)
Values(3,'Parcialmente Pago')

INSERT INTO Estado_Pedido(Cod_EstadoPedido,Estado)
Values(4,'Pago')
----****----

----Pedidos----
INSERT INTO Pedido(IDPedido, Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(1,4,1,1,2,'02/01/2021', '09:31:02')

INSERT INTO Pedido(IDPedido, Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(2,4,1,1,2,'02/01/2021', '09:15:02')

INSERT INTO Pedido(IDPedido, Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(3,4,1,1,2,'02/01/2021', '09:10:02')

INSERT INTO Pedido(IDPedido, Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(4,2,1,1,2,'03/01/2021', '09:30:02')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa,IDLocal,IDEmpregado,Dia,Hora)
Values(5,4,1,2,8,'03/01/2021','9:35:17')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(6,1,2,1,5,'03/01/2021','10:35:00')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa,IDLocal,IDEmpregado,Dia,Hora)
Values(7,3,2,2,9,'03/01/2021','10:35:02')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa,IDLocal,IDEmpregado,Dia,Hora)
Values(8,3,3,1,5, '03/01/2021','12:35:00')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(9,2,3,2,10,'03/01/2021','12:32:15')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(10,1,4,2,8,'03/01/2021','12:37:02')

INSERT INTO Pedido(IDPedido,Cod_EstadoPedido, N_Mesa, IDLocal,IDEmpregado,Dia,Hora)
Values(11,1,4,2,10,'03/01/2021','12:37:02')




---****----


----Produtos----
INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(1,'Café',0.30,0.60)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(2,'Cerveja',0.80,1.20)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(3,'Água 1.5L',0.10,1.50)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(4,'Água 0.5L',0.05,0.50)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(5,'Milka Oreo',0.10,1.0)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(6,'Coca-cola',0.20,1.10)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(7,'Pão',0.05,0.15)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(8,'Croissant',0.10,0.70)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(9,'Brownie',0.10,0.70)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(10,'Red Bull',0.70,3.10)

INSERT INTO Produto(IDProduto,Designacao,Preco_Compra,Preco_Venda)
Values(11,'Lasanha',1.2,4.10)
----****----

----Linha_Pedidos----
INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(1,1,3,3,3)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(2,4,2,2,2)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(3,5,1,1,1)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(4,7,4,4,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(4,1,2,2,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(5,2,3,3,3)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(6,1,1,0,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(6,5,3,0,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(6,4,2,0,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(7,6,2,2,1)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(7,3,2,2,1)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(8,9,3,3,2)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(9,10,2,2,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(10,11,1,0,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(10,1,3,0,0)

INSERT INTO Linha_Pedido(IDPedido,IDProduto,Qtd_Pedida,Qtd_Consumida,Qtd_Paga)
Values(11,8,2,0,0)
----****----

---Unidade Medida----
INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(1,'Saco de café',50)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(2,'Grade Cerveja',24)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(3,'Embalagem Água',6)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(4,'Embalagem Chocolates',10)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(5,'Embalagem Refrigerante',12)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(6,'Saco Pães',5)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(7,'Saco Bolos',6)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(8,'Embalagem energéticos',4)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(9,'Unidade',1)

INSERT INTO Unidade_Medida(Codigo_Unid,Designacao,Unidade)
Values(10,'Embalagem Lasanhas',4)
----****----

----Stock----
INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,1,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,2,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,3,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,4,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,5,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,6,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,7,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,8,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,9,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,10,20,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(1,11,20,9)


INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,1,15,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,2,10,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,3,5,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,4,10,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,5,7,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,6,10,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,7,6,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,8,7,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,9,5,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,10,3,9)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(2,11,2,9)


INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,1,15,1)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,2,15,2)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,3,15,3)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,4,15,3)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,5,15,4)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,6,15,5)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,7,15,6)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,8,15,7)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,9,15,7)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,10,15,8)

INSERT INTO Stock(IDLocal,IDProduto,Qtd,Codigo_Unid)
Values(3,11,15,10)



