--select da questao 3 

select f.titulo
from Filme_tb f
where rownum <= 3
order by (
 select count(*)
 from the(
 select c.emprestimos
 from Cliente_tb c
 ) emp
 where exists (
 select *
 from the(
  select fi.midias
  from Filme_Info_tb fi
  where fi.filme = ref(f)
 ) m
 where value(m) = emp.filme_r
 )
);

--Cria a tabela normal
create table Filme_tb of Filme_t
/

-- aqui cria uma tabela auxiliar que em vez de conter o
-- objeto filme ela contem um ref pra filme
create table Filme_Info_tb (
               filme ref Filme_t,
               profissionais Profissional_tb_t,
               midias Midia_tb_t
) NESTED TABLE profissionais STORE AS Profissionais_tb,
 NESTED TABLE midias STORE AS Midias_tb
/

-- aqui é o tipo simples de filme deles
create type Filme_t as object (
       titulo varchar2(128),
       ano Integer,
       categoria varchar2(32),
       oscars Integer,
       descricao varchar2(512),
       duracao Integer
)
/
--essa tabela eles fizeram pra auxiliar eh da logica deles
create type Midia_t as object (
       fabricante varchar2(32)
) NOT FINAL
/

--Aqui eh um exemplo de insert foi compilado no oracle por eles
insert into Filme_Info_tb values(
 (
 select ref(f)
 from Filme_tb f
 where f.titulo = 'Inocencia Perdida'
 ),
 Profissional_tb_t(),
 Midia_tb_t()
)
/


--exemplo de consultas
e consultei assim:

select deref(fi.filme).titulo
from Filme_Info_tb fi



select fi.midias
from Filme_Info_tb fi
where deref(fi.filme).titulo = 'Inocencia Perdida'
/