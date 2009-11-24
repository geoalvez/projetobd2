--12 Consulta:

SELECT deref(F.FILME).TITULO AS FILME, deref(VALUE(P)).NOME AS DIRETOR
FROM FILMES_TB_INFORM F, TABLE(F.PROFISSIONAIS) P
WHERE deref(F.FILME).NUM_OSCARS > 2 AND deref(VALUE(P)) IS OF (ONLY DIRETOR_TY)
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

SELECT deref(VALUE(P)).NOME AS ATOR
FROM FILMES_TB_INFORM F, TABLE(F.PROFISSIONAIS) P
WHERE deref(F.FILME).CATEGORIA='Terror' AND deref(VALUE(P)) IS OF (ONLY ATOR_TY)
ORDER BY ATOR;

--Resultado:

--ATOR
--Heverton Stuart
--Jorge Ter


--19)

--Consulta:

SELECT deref(F.FILME).TITULO, deref(F.FILME).NUM_OSCARS AS OSCARS_FILME, TREAT(deref(VALUE(P)) AS ATOR_TY).NUM_OSCARS AS OSCARS_ATOR
FROM FILMES_TB_INFORM F, TABLE(F.PROFISSIONAIS) P
WHERE deref(VALUE(P)).NOME='John Wayne' AND deref(VALUE(P)) IS OF (ONLY ATOR_TY)

--Resultado:

--FILME.TITULO	OSCARS_FILME	OSCARS_ATOR
--Troia	     1	1
--O mascara	 11	2
--O mascara 2	11	5

--15) pendente affff
SELECT deref(U).codigo
FROM the (SELECT c.emprestimos FROM CLIENTES_TB_INFORM c where deref(c.cliente).sexo='M') U


select deref(c.emprestimos)
from CLIENTES_TB_INFORM c
where deref(c.cliente).sexo='M'

select e.codigo, deref(e.filme).titulo from emprestimos_tb e;


SELECT deref(E).MULTA_PAGA
FROM CLIENTES_TB_INFORM C, TABLE(C.EMPRESTIMOS) E
WHERE deref(C.CLIENTE).CODIGO=2

--17

