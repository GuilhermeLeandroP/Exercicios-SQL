USE treinamento

--LISTA 7 

--PARTE A)Excluindo todos os pedidos que forem menores que R$ 1.000,00, que n�o possuam itens cadastrados e que sejam no m�s de junho/2003;
		SET DTDELIVER=DATEADD(DAY,30,DTDELIVER)
		WHERE DATEDIFF(DAY, DTREQUEST, DTDELIVER) < 10 AND VLTOTAL < 10000
		