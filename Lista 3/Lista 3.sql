use treinamento

--LISTA 3

--PARTE  A ) O nome do produto, o nome do fornecedor, o pre�o do produto, o pre�o com 10% de desconto, o pre�o com 20% de desconto e o pre�o com 30% de desconto para produtos cujo valor com 10% de desconto ultrapasse os 15 reais, isso ordenado por pre�o e produto;
		SELECT PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE, (PRODUCT.VLPRICE * 0.9) AS '10% DE DESCONTO', 
		(PRODUCT.VLPRICE * 0.8) AS '20% DE DESCONTO', 
		(PRODUCT.VLPRICE * 0.7) AS '30% DE DESCONTO' 
		FROM PRODUCT
		INNER JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER=PRODUCT.CDSUPPLIER
		WHERE (PRODUCT.VLPRICE * 0.9) > 15 ORDER BY PRODUCT.VLPRICE, PRODUCT.NMPRODUCT ASC 


--PARTE B )O nome do produto, o nome do fornecedor, o pre�o do produto, o pre�o total do produto no estoque e o pre�o total para o dobro do estoque para produtos com pre�o total acima de 12000, ordenados por fornecedor e produto;
		SELECT PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE, (PRODUCT.QTSTOCK * PRODUCT.VLPRICE) AS PRECOTOTAL, (PRODUCT.QTSTOCK * PRODUCT.VLPRICE * 2) 
		FROM PRODUCT 
		INNER JOIN SUPPLIER ON PRODUCT.CDSUPPLIER= SUPPLIER.CDSUPPLIER 
		WHERE PRODUCT.VLPRICE * PRODUCT.QTSTOCK >12000
		ORDER BY SUPPLIER.NMSUPPLIER, PRODUCT.NMPRODUCT


--PARTE C) Todas as colunas dos clientes que possuem telefone cadastrado e come�am com a letra J, ordenado pelo nome do cliente;
		SELECT * FROM CUSTOMER
		WHERE CUSTOMER.IDFONE IS NOT NULL AND  NMCUSTOMER LIKE 'J%'


--PARTE D)O nome do produto, o pre�o e o nome do fornecedor dos produtos que o fornecedor tenha no nome os caracteres �ica�, ordenado por fornecedor e pre�o;

		SELECT PRODUCT.NMPRODUCT, PRODUCT.VLPRICE, SUPPLIER.NMSUPPLIER 
		FROM PRODUCT 
		INNER JOIN SUPPLIER ON PRODUCT.CDSUPPLIER=SUPPLIER.CDSUPPLIER
		WHERE SUPPLIER.NMSUPPLIER LIKE '%ica%' 
		ORDER BY SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE


--PARTE E)O nome do fornecedor, o fone do fornecedor, o nome do produto, o pre�o e o pre�o total do produto no estoque para produtos que comecem com a letra S, tendo pre�o acima de 50, ordenado por fornecedor e pre�o;

		SELECT SUPPLIER.NMSUPPLIER, SUPPLIER.IDFONE,PRODUCT.NMPRODUCT,PRODUCT.VLPRICE, PRODUCT.QTSTOCK * PRODUCT.VLPRICE
		FROM PRODUCT 
		INNER JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER=PRODUCT.CDSUPPLIER 
		WHERE PRODUCT.VLPRICE >50 
		AND  PRODUCT.NMPRODUCT LIKE 'S%'


--PARTE F)O nome do cliente, o nome do produto, a data do pedido, a data de entrega, a quantidade pedida, o valor unit�rio de venda dos produtos e o valor total do produto pedido, cujas unidades pedidas por pedido sejam menor que 600 e a data do pedido seja no m�s de agosto de 2003 e o produto comece com a letra M;

		SELECT CUSTOMER.NMCUSTOMER, PRODUCT.NMPRODUCT, REQUEST.DTREQUEST, REQUEST.DTDELIVER, PRODUCTREQUEST.QTAMOUNT, PRODUCTREQUEST.VLUNITARY, REQUEST.VLTOTAL 
		FROM PRODUCTREQUEST 
		INNER JOIN PRODUCT ON PRODUCT.CDPRODUCT=PRODUCTREQUEST.CDPRODUCT
		INNER JOIN REQUEST ON REQUEST.CDREQUEST=PRODUCTREQUEST.CDREQUEST 
		INNER JOIN CUSTOMER ON REQUEST.CDREQUEST=PRODUCTREQUEST.CDREQUEST AND REQUEST.CDCUSTOMER=CUSTOMER.CDCUSTOMER
		WHERE (REQUEST.VLTOTAL / PRODUCTREQUEST.VLUNITARY) < 600 AND
		REQUEST.DTREQUEST BETWEEN '20030801' and '20030831' AND
		PRODUCT.NMPRODUCT LIKE 'm%'


--PARTE G )O nome do cliente, o nome do produto o nome do fornecedor, a data do pedido, a data de entrega e o pre�o, somente se o fornecedor for de S�o Paulo(011) e o pre�o seja maior que 20 reais.

		SELECT CUSTOMER.NMCUSTOMER, PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, REQUEST.DTREQUEST, REQUEST.DTDELIVER, PRODUCT.VLPRICE
		FROM PRODUCTREQUEST
		INNER JOIN PRODUCT ON PRODUCT.CDPRODUCT=PRODUCTREQUEST.CDPRODUCT
		INNER JOIN REQUEST ON REQUEST.CDREQUEST=PRODUCTREQUEST.CDREQUEST
		INNER JOIN CUSTOMER ON REQUEST.CDREQUEST=PRODUCTREQUEST.CDREQUEST AND REQUEST.CDCUSTOMER=CUSTOMER.CDCUSTOMER
		INNER JOIN SUPPLIER ON PRODUCT.CDPRODUCT=PRODUCTREQUEST.CDPRODUCT AND PRODUCT.CDSUPPLIER=SUPPLIER.CDSUPPLIER
		WHERE SUPPLIER.IDFONE LIKE '%(011)%' AND VLPRICE > 20
