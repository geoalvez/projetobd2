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
ORDER BY FILME;

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

--15	OK
SELECT C.CATEGORIA
FROM
(
	SELECT E.FILME.CATEGORIA AS CATEGORIA, COUNT(*) AS OCORRENCIAS
	FROM CLIENTES_INFO_TB C, TABLE(C.EMPRESTIMOS) E
	WHERE C.CLIENTE.SEXO = 'M'
	GROUP BY E.FILME.CATEGORIA
) C
WHERE C.OCORRENCIAS =
(
	SELECT MAX(O.OCORRENCIAS)
	FROM
	(
		SELECT E.FILME.CATEGORIA AS CATEGORIA, COUNT(*) AS OCORRENCIAS
		FROM CLIENTES_INFO_TB C, TABLE(C.EMPRESTIMOS) E
		WHERE C.CLIENTE.SEXO = 'M'
		GROUP BY E.FILME.CATEGORIA
	) O
)

--CATEGORIA
--Comedia
--##

--16	OK
SELECT F.CATEGORIA, COUNT(*) AS NUM_FILMES
FROM FILMES_TB F
WHERE F.CODIGO NOT IN
(
	SELECT R.FILME.CODIGO
	FROM CLIENTES_INFO_TB C, TABLE(C.RESERVAS) R
	WHERE R.DATA_RESERVA > (SELECT SYSDATE - 730 FROM DUAL)
)
GROUP BY F.CATEGORIA
--730 eh o numero de dias em 2 anos


--Resultado

--CATEGORIA	NUMVEZES
--Fim dos tempos	1
--Drama	1
--Comedia	2
--##

--17	OK
SELECT C.CLIENTE.NOME AS NOME_CLIENTE, T.COLUMN_VALUE AS TELEFONES, E.COLUMN_VALUE AS EMAILS
FROM CLIENTES_INFO_TB C, TABLE(C.CLIENTE.EMAILS) E, TABLE(C.CLIENTE.TELEFONES) T, TABLE(C.EMPRESTIMOS) EMP
WHERE EMP.FILME.TITULO = 'Troia'
ORDER BY NOME_CLIENTE

--Resultado
--CLIENTE.NOME	COLUMN_VALUE	COLUMN_VALUE
--Luiz Gonzaga	(83)3333-3333	lg@gmail.com
--Luiz Gonzaga	(83)8888-8888	lg@gmail.com
--##

--18	OK
SELECT	C.CLIENTE.NOME AS NOME_CLIENTE, D.NOME AS NOME_DEPENDENTE
FROM CLIENTES_INFO_TB C, TABLE(C.DEPENDENTES) D
WHERE D.SEXO = 'M'
ORDER BY NOME_CLIENTE

--Resultado
--NOMECLIENTE	NOMEDEPENDENTE
--Jackson do Pandeiro	Fernando Fagundes
--Jackson do Pandeiro	Jeysibel da silva
--Luiz Gonzaga	Romeryto Lira
--Marinez	Geo Alvez

--##

--19	OK
SELECT F.FILME.TITULO AS FILME_TITULO, F.FILME.NUM_OSCARS AS FILME_OSCARS, TREAT(VALUE(P) AS ATOR_TY).NUM_OSCARS AS OSCARS_ATOR
FROM FILMES_INFO_TB F, TABLE(F.PROFISSIONAIS) P
WHERE VALUE(P).NOME = 'John Wayne' AND VALUE(P) IS OF (ONLY ATOR_TY)
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