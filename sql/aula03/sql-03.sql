--------------------------------------------
-- SQL para Analytics: Join and Having in SQL
--------------------------------------------

-- Inner Join
--------------------------------------------

-- Uso: Utilizado quando você precisa de registros que têm correspondência exata em ambas as tabelas.

-- Exemplo Prático: 
-- Se quisermos encontrar todos os pedidos de 1996 e os detalhes dos clientes que fizeram esses pedidos, 
-- usamos um Inner Join. Isso garante que só obteremos os pedidos que possuem um cliente correspondente e que foram feitos em 1996.

-- Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)
SELECT *
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1996; -- EXTRACT(part FROM date) part pode ser YEAR, MONTH, DAY, etc

-- Left Join
--------------------------------------------

-- Uso: Usado quando você quer todos os registros da primeira (esquerda) tabela, com os correspondentes da segunda (direita) tabela. 
-- Se não houver correspondência, a segunda tabela terá campos NULL.

-- Exemplo Prático: 
-- Se precisarmos listar todas as cidades onde temos funcionários, e também queremos saber quantos clientes temos nessas cidades, 
-- mesmo que não haja clientes, usamos um Left Join.

-- Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)
SELECT e.city AS cidade, 
       COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios, 
       COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e 
LEFT JOIN customers c ON e.city = c.city
GROUP BY e.city
ORDER BY cidade;

-- Right Join
--------------------------------------------

-- Uso: É o inverso do Left Join e é menos comum. Usado quando queremos todos os registros da segunda (direita) tabela e os correspondentes da 
-- primeira (esquerda) tabela.

-- Exemplo Prático: 
-- Para listar todas as cidades onde temos clientes, e também contar quantos funcionários temos nessas cidades, usamos um Right Join.
-- Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)
SELECT c.city AS cidade, 
       COUNT(DISTINCT c.customer_id) AS numero_de_clientes, 
       COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios
FROM employees e 
RIGHT JOIN customers c ON e.city = c.city
GROUP BY c.city
ORDER BY cidade;

-- Full Join
--------------------------------------------

-- Uso: Utilizado quando queremos a união de Left Join e Right Join, mostrando todos os registros de ambas as tabelas, e preenchendo 
-- com NULL onde não há correspondência.

-- Exemplo Prático: 
-- Para listar todas as cidades onde temos clientes ou funcionários, e contar ambos em cada cidade, usamos um Full Join.
-- Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)
SELECT
	COALESCE(e.city, c.city) AS cidade,
	COUNT(DISTINCT e.employee_id) AS numero_de_funcionarios,
	COUNT(DISTINCT c.customer_id) AS numero_de_clientes
FROM employees e 
FULL JOIN customers c ON e.city = c.city
GROUP BY e.city, c.city
ORDER BY cidade;

-- Having
--------------------------------------------

-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)
SELECT o.product_id, p.product_name, SUM(o.quantity) AS quantidade_total
FROM order_details o
JOIN products p ON p.product_id = o.product_id
GROUP BY o.product_id, p.product_name
HAVING SUM(o.quantity) < 200
ORDER BY quantidade_total DESC;

-- Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)
SELECT customer_id, COUNT(order_id) AS total_de_pedidos
FROM orders
WHERE order_date > '1996-12-31'
GROUP BY customer_id
HAVING COUNT(order_id) > 15
ORDER BY total_de_pedidos;