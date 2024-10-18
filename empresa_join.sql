create database empresa_join;
use empresa_join;

create table departamento(
	id_dep bigint auto_increment primary key,
    nome varchar(255)
);

create table funcionario(
	id_func int auto_increment primary key,
    salario decimal(10,2),
    nome varchar(100),
    id_dep bigint,
    foreign key(id_dep) references departamento(id_dep)
);

create table dependente(
	id_depen int auto_increment primary key,
    nome varchar(100),
    id_func int,
    foreign key (id_func) references funcionario(id_func)
);

insert into departamento(nome)
	values ("RH"),("ADM"),("GESTÃO"),("FINANCEIRO"),("MARKETING");
    
insert into funcionario(nome, salario, id_dep)
	values 	("REGINALDO", 2000.00, 5),
			("GILBERTA", 2200.00, 3),
            ("CHAVES", 1800.00, 2),
            ("HEREMINA", 2700.00, 1),
            ("PRINA", 3000.00, 4);
            
insert into dependente(nome, id_func)
	values	("MAXIMILIANO", 4),
			("CHARLOTTE", 1),
            ("CASTY", 1),
            ("LOUIS", 3),
            ("LIANA", 2);
            
select funcionario.nome FUNCIONARIO, count(dependente.id_depen) AS QTD_DEPENDENTES
from funcionario
inner join dependente 
on funcionario.id_func = dependente.id_func
group by funcionario.nome
having count(dependente.id_depen) > 1;


select departamento.nome DEPARTAMENTO, funcionario.nome FUNCIONARIO
from departamento 
left join funcionario 
on departamento.id_dep = funcionario.id_dep
order by funcionario.nome asc;

select funcionario.nome FUNCIONARIO, dependente.nome DEPENDENTE
from funcionario 
left join dependente
on funcionario.id_func = dependente.id_func;

select departamento.nome DEPARTAMENTO, AVG(funcionario.salario) AS MEDIA_SALARIAL
from departamento
left join funcionario 
on departamento.id_dep = funcionario.id_dep
group by departamento.nome;

select SUM(salario) as TOTAL_SALARIO
from funcionario;

select departamento.nome DEPARTAMENTO, SUM(funcionario.salario) CUSTO_SETOR
from departamento 
left join funcionario  
on departamento.id_dep = funcionario.id_dep
group by departamento.nome;
