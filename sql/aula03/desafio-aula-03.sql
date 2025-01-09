-- Desafio

-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)
select *
from customers c
    JOIN orders o ON c.customer_id = o.customer_id
WHERE
    EXTRACT(
        YEAR
        FROM o.order_date
    ) = 1996;

-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)
select
    e.city as cidade,
    count(distinct e.employee_id) as numero_de_funcionarios,
    count(distinct c.customer_id) as numero_de_clientes
from employees e
    LEFT JOIN customers c ON e.city = c.city
group by
    e.city
order by cidade;

-- 3. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)
select
    c.city as cidade,
    count(distinct e.employee_id) as numero_de_funcionarios,
    count(distinct c.customer_id) as numero_de_clientes
from customers c
    LEFT JOIN employees e ON c.city = e.city
group by
    c.city
order by cidade;

-- 4.Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)
SELECT
    c.city as cidade,
    count(distinct e.employee_id) as numero_de_funcionarios,
    count(distinct c.customer_id) as numero_de_clientes
from employees e
    FULL JOIN customers c ON e.city = c.city
group by
    c.city
order by cidade;


-- 5. Cria um relatório que mostra a quantidade total de produtos encomendados.
-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)
select o.product_id, p.product_name, sum(o.quantity) as quantidade_total
from order_details o
    JOIN products p ON o.product_id = p.product_id
group by
    o.product_id,
    p.product_name
having
    sum(o.quantity) < 200
order by quantidade_total desc;


-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)
select customer_id, count(order_id) as total_de_pedidos
from orders
where
    order_date >= '1996-12-31'
GROUP BY
    customer_id
HAVING
    count(order_id) > 15
order by total_de_pedidos;