--02
--##

--03
--##

--04
--##

--05
--##

--06
--##

--07	OK
ALTER TYPE FILME_TY
    DROP MEMBER FUNCTION DURACAOEMHORAS RETURN NUMBER CASCADE;

ALTER TYPE FILME_TY
    ADD MEMBER FUNCTION DURACAOEMHORAS RETURN NUMBER CASCADE;

CREATE OR REPLACE TYPE BODY FILME_TY IS
    MEMBER FUNCTION  DURACAOEMHORAS  RETURN NUMBER IS
    BEGIN
        RETURN SELF.DURACAO/60;
    END;
END;
--##

--08
--##

--09
--##

--10
--##

--11
--##

--12	OK
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
--##

--13	OK
SELECT E.FILME.TITULO AS FILME, COUNT(*) AS NUM_ALUGUEIS
FROM EMPRESTIMOS_STB E
GROUP BY E.FILME.TITULO
ORDER BY NUM_ALUGUEIS DESC


--FILME.TITULO	NUM_ALUGUEIS
--O mascara 2	2
--O mascara	1
--Jogos mortais	1
--##

--14	OK
SELECT VALUE(P).NOME AS NOME_ATOR
FROM FILMES_INFO_TB F, TABLE(F.PROFISSIONAIS) P
WHERE F.FILME.CATEGORIA = 'Terror' AND VALUE(P) IS OF (ONLY ATOR_TY)
ORDER BY NOME_ATOR;

--Resultado:

--ATOR
--Heverton Stuart
--Jorge Ter
--##

--15				PENDENTE!!!!!!!!!!!!!!!!!!!
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
--##

--16
select f.categoria, count(*) as numvezes
from filmes_tb f
where f.codigo not in
(select y.filme.codigo as codigo_filme
from CLIENTES_INFO_TB c, TABLE(c.reservas) y
where y.data_reserva > (SELECT SYSDATE - 730  FROM DUAL))
group by f.categoria

--730 eh o numero de dias em 2 anos


--Resultado

--CATEGORIA	NUMVEZES
--Fim dos tempos	1
--Drama	1
--Comedia	2
--##

--17
select c.cliente.nome, t.* , e.*
from clientes_info_tb c, table(c.cliente.emails) e, table(c.cliente.telefones) t,  TABLE(c.emprestimos) w
where w.filme.titulo='Troia'

--Resultado
--CLIENTE.NOME	COLUMN_VALUE	COLUMN_VALUE
--Luiz Gonzaga	(83)3333-3333	lg@gmail.com
--Luiz Gonzaga	(83)8888-8888	lg@gmail.com
--##

--18
--##

--19
SELECT F.FILME.TITULO, F.FILME.NUM_OSCARS AS OSCARS_FILME, TREAT(VALUE(P) AS ATOR_TY).NUM_OSCARS AS OSCARS_ATOR
FROM FILMES_INFO_TB F, TABLE(F.PROFISSIONAIS) P
WHERE VALUE(P).NOME='John Wayne' AND VALUE(P) IS OF (ONLY ATOR_TY)
--Resultado:

--FILME.TITULO	OSCARS_FILME	OSCARS_ATOR
--Troia	     1	1
--O mascara	 11	2
--O mascara 2	11	5
--##

--20	OK
SELECT F.TITULO AS TITULO_FILME
FROM FILMES_TB F
WHERE F.DURACAOEMHORAS() > 2;  

--Resultado:
--TITULO
--Titanic
--2012
--Jogos mortais
--O mascara
--O mascara 2
--##