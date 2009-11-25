--12 Consulta:

SELECT F.FILME.TITULO AS FILME, VALUE(P).NOME AS DIRETOR
FROM FILMES_INFO_TB F, TABLE(F.PROFISSIONAIS) P
WHERE F.FILME.NUM_OSCARS > 2 AND VALUE(P) IS OF (ONLY DIRETOR_TY)
ORDER BY F.FILME.TITULO;

--RESULTADO:
--FILME	DIRETOR
--Jogos mortais	Arinaldo da Silva
--Jogos mortais	George Marcelo
--O mascara	Claudio Batista
--O mascara 2	Claudio Batista
--Titanic	James Cameron
--Titanic	John Landau
--2012	John Smith

--7)

ALTER TYPE FILME_TY
    DROP MEMBER FUNCTION duracaoEmHoras RETURN NUMBER CASCADE;


ALTER TYPE FILME_TY
    ADD MEMBER FUNCTION duracaoEmHoras RETURN NUMBER CASCADE;


CREATE OR REPLACE TYPE BODY FILME_TY IS
    MEMBER FUNCTION  duracaoEmHoras  RETURN NUMBER IS
    BEGIN
        return self.duracao/60;
    END;
END;

--20)

--Consulta:

select f.titulo from FILMES_TB f
  where f.duracaoEmHoras() > 2  


--Resultado:

--TITULO
--Titanic
--2012
--Jogos mortais
--O mascara
--O mascara 2


--14)

--Consulta:

SELECT VALUE(P).NOME AS ATOR
FROM FILMES_INFO_TB F, TABLE(F.PROFISSIONAIS) P
WHERE F.FILME.CATEGORIA='Terror' AND VALUE(P) IS OF (ONLY ATOR_TY)
ORDER BY ATOR;

--Resultado:

--ATOR
--Heverton Stuart
--Jorge Ter


--19)

--Consulta:

SELECT F.FILME.TITULO, F.FILME.NUM_OSCARS AS OSCARS_FILME, TREAT(VALUE(P) AS ATOR_TY).NUM_OSCARS AS OSCARS_ATOR
FROM FILMES_INFO_TB F, TABLE(F.PROFISSIONAIS) P
WHERE VALUE(P).NOME='John Wayne' AND VALUE(P) IS OF (ONLY ATOR_TY)
--Resultado:

--FILME.TITULO	OSCARS_FILME	OSCARS_ATOR
--Troia	     1	1
--O mascara	 11	2
--O mascara 2	11	5

--5)

CREATE OR REPLACE PROCEDURE CRIACLIENTE
(
    CPF_IN     IN CLIENTES_TB.CPF%TYPE,
    NOME_IN    IN CLIENTES_TB.NOME%TYPE
)
AS
BEGIN
    INSERT INTO CLIENTES_TB VALUES
    (
        CLIENTE_TY
            (
                (SELECT COUNT(*) FROM CLIENTES_TB) + 1, --GERA UM CODIGO PARA O CLIENTE
                NOME_IN,
                CPF_IN,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL
         )
);
END;

--para rodar

BEGIN
CRIACLIENTE(11111111111, 'cliente st');
END;

--Para verificar se adicionou

select * from clientes_tb

--17

select c.cliente.nome, t.* , e.*
from clientes_info_tb c, table(c.cliente.emails) e, table(c.cliente.telefones) t,  TABLE(c.emprestimos) w
where w.filme.titulo='Troia'

--Resultado
--CLIENTE.NOME	COLUMN_VALUE	COLUMN_VALUE
--Luiz Gonzaga	(83)3333-3333	lg@gmail.com
--Luiz Gonzaga	(83)8888-8888	lg@gmail.com

--15) pendente affff
select t.categoria from
(select y.filme.categoria as categoria, count(*) as ocorrencias
from CLIENTES_INFO_TB c, TABLE(c.emprestimos) y
where c.cliente.sexo='M'
group by y.filme.categoria) t where t.ocorrencias = (

 select max(a.ocorrencias) from (


select y.filme.categoria as categoria, count(*) as ocorrencias
from CLIENTES_INFO_TB c, TABLE(c.emprestimos) y
where c.cliente.sexo='M'
group by y.filme.categoria


)a

 )

--CATEGORIA
--Comedia

--13
select f.filme.titulo , count(*) as num_alugueis 
from emprestimos_stb f
group by f.filme.titulo
order by num_alugueis DESC  

--FILME.TITULO	NUM_ALUGUEIS
--O mascara 2	2
--O mascara	1
--Jogos mortais	1

