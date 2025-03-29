with emp_salarios as (
select 
e.matr,
e.nome,
e.lotacao, --ASSUMNIDO QUE ESSA COLUNA É O COD DO DEPARTAMENTO
coalesce(sum(v.valor),0) as soma
from empregado e 
left join emp_venc ev 
on e.matr = ev.matr
left join vencimento v 
on ev.cod_venc = v.cod_venc
group by
e.matr,
e.nome,
e.lotacao
)
select 
d.nome as DEPARTAMENTO,
count(distinct emp_salarios.nome) as N_FUNCIONARIOS,
round(avg(emp_salarios.soma),2) as MEDIA,
max(emp_salarios.soma) as MAXIMO,
min(emp_salarios.soma) as MINIMO
from departamento d 
left join emp_salarios 
on d.cod_dep = emp_salarios.lotacao
group by
d.nome
order by media DESC