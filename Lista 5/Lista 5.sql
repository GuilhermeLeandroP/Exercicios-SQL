use treinamento

--LISTA 5)


--PARTE A)O nome de todos os produtos e quantas vezes ele foi vendido, mesmo que n�o tenha sido vendido ainda;

		SELECT PRODUCT.NMPRODUCT, COUNT(REQUEST.DTREQUEST) AS QTD
		FROM PRODUCTREQUEST
		INNER JOIN PRODUCT ON PRODUCTREQUEST.CDPRODUCT=PRODUCT.CDPRODUCT
		INNER JOIN REQUEST ON PRODUCTREQUEST.CDREQUEST=REQUEST.CDREQUEST
		GROUP BY PRODUCT.NMPRODUCT

--PARTE B)O nome do fornecedor, e o n�mero de produtos que ele fornece, mesmo que n�o tenha fornecido produto algum;
		SELECT SUPPLIER.NMSUPPLIER, COUNT(PRODUCT.CDSUPPLIER) AS 'QTD PRODUTOS'
		FROM PRODUCT
		INNER JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER=PRODUCT.CDSUPPLIER
		GROUP BY SUPPLIER.NMSUPPLIER

--PARTE C)O nome do fornecedor, o produto e qual o total de produtos dele j� vendidos. Uma linha do total por fornecedor e uma linha com o total geral;
		SELECT SUPPLIER.NMSUPPLIER, PRODUCT.NMPRODUCT, COUNT(REQUEST.CDREQUEST) AS 'TOT PRODUTOS VENDIDOS'
		FROM PRODUCTREQUEST 
		INNER JOIN PRODUCT ON PRODUCTREQUEST.CDPRODUCT=PRODUCT.CDPRODUCT
		INNER JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER= PRODUCT.CDSUPPLIER AND PRODUCTREQUEST.CDPRODUCT=PRODUCT.CDPRODUCT
		INNER JOIN REQUEST ON REQUEST.CDREQUEST= PRODUCTREQUEST.CDREQUEST
		GROUP BY SUPPLIER.NMSUPPLIER,PRODUCT.NMPRODUCT
		UNION 
		SELECT  SUPPLIER.NMSUPPLIER,'TOTAL',COUNT(REQUEST.CDREQUEST) 
		FROM PRODUCTREQUEST
		INNER JOIN PRODUCT ON PRODUCTREQUEST.CDPRODUCT=PRODUCT.CDPRODUCT
		INNER JOIN REQUEST ON PRODUCTREQUEST.CDREQUEST=REQUEST.CDREQUEST
		INNER JOIN SUPPLIER ON  SUPPLIER.CDSUPPLIER=PRODUCT.CDSUPPLIER
		GROUP BY SUPPLIER.NMSUPPLIER
		UNION
		SELECT 'FORNECEDORES','TOTAL',COUNT(*)
		FROM PRODUCTREQUEST
--PARTE D) O nome do cliente, o produto e o total que o cliente j� gastou com esse produto. Uma linha com o total por cliente e uma linha com o total geral;

		SELECT C.NMCUSTOMER, P.NMPRODUCT,SUM(P.VLPRICE) AS 'GASTO '
		FROM PRODUCTREQUEST PR
		INNER JOIN PRODUCT P ON P.CDPRODUCT=PR.CDPRODUCT
		INNER JOIN REQUEST R ON R.CDREQUEST=PR.CDREQUEST
		INNER JOIN CUSTOMER C ON C.CDCUSTOMER=R.CDCUSTOMER AND R.CDREQUEST=PR.CDREQUEST
		GROUP BY C.NMCUSTOMER, P.NMPRODUCT
		UNION
		SELECT C.NMCUSTOMER,'TOTAL',SUM(P.VLPRICE) AS 'GASTO '
		FROM PRODUCTREQUEST PR
		INNER JOIN PRODUCT P ON P.CDPRODUCT=PR.CDPRODUCT
		INNER JOIN REQUEST R ON R.CDREQUEST=PR.CDREQUEST
		INNER JOIN CUSTOMER C ON C.CDCUSTOMER=R.CDCUSTOMER AND R.CDREQUEST=PR.CDREQUEST
		GROUP BY C.NMCUSTOMER
		UNION
		SELECT 'CLIENTES','TOTAL',SUM(P.VLPRICE) AS 'GASTO '
		FROM PRODUCTREQUEST PR
		INNER JOIN PRODUCT P ON P.CDPRODUCT=PR.CDPRODUCT
		ORDER BY C.NMCUSTOMER
--PARTE E)O nome e o telefone de todos os clientes que ainda n�o compraram produtos;


		SELECT C.NMCUSTOMER, C.IDFONE
		FROM CUSTOMER C
		LEFT JOIN REQUEST R 
		ON R.CDCUSTOMER = C.CDCUSTOMER
		WHERE R.CDCUSTOMER IS  NULL

--PARTE F) O nome e o telefone dos fornecedores que fornecem o produto �leite em po�  ou o produto �agua mineral�;

		SELECT S.NMSUPPLIER, S.IDFONE FROM SUPPLIER S
		INNER JOIN PRODUCT P ON P.CDSUPPLIER=S.CDSUPPLIER
		WHERE P.NMPRODUCT = 'leite em po' OR  P.NMPRODUCT ='agua mineral'

--PARTE G) O nome e o fornecedor do produto que j� foi vendido mais que 3 vezes.
	
	SELECT P.NMPRODUCT,S.NMSUPPLIER 
	FROM PRODUCT P
	INNER JOIN SUPPLIER S ON S.CDSUPPLIER=P.CDSUPPLIER
	INNER JOIN PRODUCTREQUEST PR ON PR.CDPRODUCT=P.CDPRODUCT
	GROUP BY P.NMPRODUCT,S.NMSUPPLIER 
	HAVING SUM(PR.CDPRODUCT)>3
