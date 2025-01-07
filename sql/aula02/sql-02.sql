-- Outros operadores
--------------------------------------------

-- Operador < (Menor que) 
--------------------------------------------
-- Seleciona todos os produtos com preço menor que 20
SELECT * FROM products WHERE unit_price < 20;

-- Operador > (Maior que) 
--------------------------------------------
-- Seleciona todos os produtos com preço maior que 100
SELECT * FROM products WHERE unit_price > 100;

-- Operador <= (Menor ou igual a)
--------------------------------------------
-- Seleciona todos os produtos com preço maior que 100
SELECT * FROM products WHERE unit_price > 100;

-- Operador >= (Maior ou igual a)
--------------------------------------------
-- Seleciona todos os produtos com quantidade em estoque maior ou igual a 10
SELECT * FROM products WHERE units_in_stock >= 10;

-- Operador >= (Maior ou igual a)
--------------------------------------------
-- Seleciona todos os produtos cujo preço não é 30
SELECT * FROM products WHERE unit_price <> 30;


-- Combinação de Operadores
--------------------------------------------

-- Seleciona todos os produtos com preço entre 50 e 100 (exclusive)
SELECT * FROM products
WHERE unit_price >= 50 AND unit_price < 100;

-- Seleciona todos os produtos com preço fora do intervalo 20 a 40
SELECT * FROM products
WHERE unit_price < 20 OR unit_price > 40;

-- Is null and is not null: Usado em conjunto com o where para criar regras mais complexas de filtro nos registros.
--------------------------------------------
SELECT * FROM customers WHERE contact_name is Null;

SELECT * FROM customers WHERE contact_name is not null;

-- LIKE
--------------------------------------------
-- Nome do cliente começando com "a":
SELECT * FROM customers WHERE contact_name LIKE '%a%';

-- LOWER
--------------------------------------------
-- Encontrar nomes que começam com "a" em maiúscula ou minúscula
SELECT * FROM customers WHERE LOWER(contact_name) LIKE 'a%';

-- UPPER
--------------------------------------------
-- Encontrar nomes que começam com "A" em maiúscula
SELECT * FROM customers WHERE UPPER(contact_name) LIKE 'A%';

-- Nome do cliente terminando com "a":
SELECT * FROM customers WHERE contact_name LIKE '%a';

-- Nome do cliente que possui "or" em qualquer posição:
SELECT * FROM customers WHERE contact_name LIKE '%or%';

-- Nome do cliente com "r" na segunda posição:
SELECT * FROM customers WHERE contact_name LIKE '_r%';

-- Nome do cliente que começa com "A" e tem pelo menos 3 caracteres de comprimento:
SELECT * FROM customers WHERE contact_name LIKE 'A_%_%';

-- Nome do contato que começa com "A" e termina com "o":
SELECT * FROM customers WHERE contact_name LIKE 'A%o';

-- Nome do cliente que NÃO começa com "a":
SELECT * FROM customers WHERE contact_name NOT LIKE 'A%';

-- Usando o curinga Similar To (Postgres)
SELECT * FROM customers WHERE city SIMILAR TO '(B|S|P)%';

-- IN
--------------------------------------------
-- Localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers WHERE country IN ('Germany', 'France', 'UK');

-- NÃO localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers WHERE country NOT IN ('Germany', 'France', 'UK');

-- Só para dar um gostinho de uma subqueyr... Seleciona todos os clientes que são dos mesmos países que os fornecedores:
SELECT * FROM customers WHERE country IN (SELECT country FROM suppliers);

-- BETWEEN
--------------------------------------------
SELECT * FROM products WHERE unit_price BETWEEN 10 AND 20;

-- NOT BETWEEN
--------------------------------------------
SELECT * FROM products WHERE unit_price NOT BETWEEN 10 AND 20;

-- Seleciona todos os produtos com preço ENTRE 10 e 20. Adicionalmente, não mostra produtos com CategoryID de 1, 2 ou 3:
SELECT * FROM products WHERE (unit_price BETWEEN 10 AND 20) AND category_id NOT IN (1, 2, 3);

-- Funções Agregadas (COUNT, MAX, MIN, SUM, AVG)
--------------------------------------------

-- Exemplo de MIN()
SELECT MIN(unit_price) AS preco_minimo
FROM products;

-- Exemplo de MAX()
SELECT MAX(unit_price) AS preco_maximo
FROM products;

-- Exemplo de COUNT()
SELECT COUNT(*) AS total_de_produtos
FROM products;

-- Exemplo de AVG()
SELECT AVG(unit_price) AS preco_medio
FROM products;

-- Exemplo de SUM()
SELECT SUM(quantity) AS quantidade_total_de_order_details
FROM order_details;

-- Práticas Recomendadas
-- Precisão de dados: Ao usar AVG() e SUM(), esteja ciente do tipo de dados da coluna para evitar imprecisões, especialmente com dados flutuantes.
-- NULLs: Lembre-se de que a maioria das funções agregadas ignora valores NULL, exceto COUNT(*), que conta todas as linhas, incluindo aquelas com valores NULL.
-- Performance: Em tabelas muito grandes, operações agregadas podem ser custosas em termos de desempenho. Considere usar índices adequados ou realizar pré-agregações quando aplicável.
-- Clareza: Ao usar GROUP BY, assegure-se de que todas as colunas não agregadas na sua cláusula SELECT estejam incluídas na cláusula GROUP BY.

-- MIN() com GROUP BY
--------------------------------------------
-- Calcula o menor preço unitário de produtos em cada categoria
SELECT category_id, MIN(unit_price) AS preco_minimo
FROM products
GROUP BY category_id;

-- MAX() com GROUP BY
--------------------------------------------
-- Calcula o maior preço unitário de produtos em cada categoria
SELECT category_id, MAX(unit_price) AS preco_maximo
FROM products
GROUP BY category_id;

-- COUNT() com GROUP BY
--------------------------------------------
-- Conta o número total de produtos em cada categoria
SELECT category_id, COUNT(*) AS total_de_produtos
FROM products
GROUP BY category_id;

-- AVG() com GROUP BY
--------------------------------------------
-- Calcula o preço médio unitário de produtos em cada categoria
SELECT category_id, AVG(unit_price) AS preco_medio
FROM products
GROUP BY category_id;

-- SUM() com GROUP BY
--------------------------------------------
-- Calcula a quantidade total de produtos pedidos por pedido
SELECT order_id, SUM(quantity) AS quantidade_total_por_pedido
FROM order_details
GROUP BY order_id;