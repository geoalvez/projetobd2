--02 OK

CREATE OR REPLACE PROCEDURE RELATORIODEEMPRESTIMOS
(
	CPF_IN IN NUMBER,
	DATA_IN IN DATE
) AS
	CURSOR C IS
		SELECT C.CLIENTE.NOME AS NOME_CLIENTE,
			  E.DATA_EMPRESTIMO AS DATA_EMPRESTIMO,
			  E.DATA_ENTREGA AS DATA_DE_ENTREGA,
			  E.VALOR_EMPRESTIMO AS VALOR_EMPRESTIMO,
			  E.VALOR_MULTA AS VALOR_DA_MULTA,
			  E.MULTA_PAGA AS MULTA_PAGA,
			  E.FILME.TITULO AS TITULO_FILME
		FROM CLIENTES_INFO_TB C, TABLE(C.EMPRESTIMOS) E
		WHERE C.CLIENTE.CPF = CPF_IN AND E.DATA_EMPRESTIMO > DATA_IN
		ORDER BY DATA_EMPRESTIMO;
	CP C %ROWTYPE;
BEGIN
	OPEN C;
	LOOP
		FETCH C INTO CP;
		EXIT WHEN C%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE
		(
			'NOME CLIENTE: ' || CP.NOME_CLIENTE || 
			' DATA EMP.: ' || CP.DATA_EMPRESTIMO || 
		    ' DATA ENTREGA: ' || CP.DATA_DE_ENTREGA || 
			' VALOR EMP.: ' || CP.VALOR_EMPRESTIMO  || 
			' VALOR DA MULTA: ' || CP.VALOR_DA_MULTA || 
			' MULTA PAGA: ' || CP.MULTA_PAGA || 
			' FILME EMPRESTADO: ' || CP.TITULO_FILME
		);
	END LOOP;
	CLOSE C;
END;

--TESTANDO...
--	OBS: VERSAO DO ORACLE EM INGLES USAR TO_DATE('01/JAN/09')
BEGIN
	RELATORIODEEMPRESTIMOS
	(
		88888888888,
		TO_DATE('01/01/09')
	);
END;

--##





--03	OK
CREATE OR REPLACE PROCEDURE LISTARTOP5 
(
	MES IN NUMBER
) AS 
	CURSOR C IS
		SELECT FILME
		FROM 
		(
			SELECT E.FILME.TITULO AS FILME, COUNT(*) AS NUM_ALUGUEIS
			FROM EMPRESTIMOS_STB E WHERE EXTRACT(MONTH FROM E.DATA_EMPRESTIMO) = MES
			GROUP BY E.FILME.TITULO
			ORDER BY NUM_ALUGUEIS DESC
		)
		WHERE ROWNUM <= 5;
	CP C %ROWTYPE;
BEGIN
	OPEN C;
	LOOP
		FETCH C INTO CP;
		EXIT WHEN C%NOTFOUND;
		dbms_output.put_line('FILME: ' || CP.FILME);
	END LOOP;
	CLOSE C;
END;

--para rodar

BEGIN

LISTARTOP5 
(
	01
) ;
END;

--##




--04	OK
CREATE OR REPLACE PROCEDURE LISTARDEVEDORES AS
	CURSOR C IS
		SELECT C.CLIENTE.CPF AS CPF, C.CLIENTE.NOME AS NOME, E.COLUMN_VALUE AS EMAIL, SUM(EMP.VALOR_MULTA) AS TOTAL_DEBITO
		FROM CLIENTES_INFO_TB C, TABLE(C.CLIENTE.EMAILS) E, TABLE(C.EMPRESTIMOS) EMP
		WHERE EMP.MULTA_PAGA = 0
		GROUP BY (C.CLIENTE.CPF, C.CLIENTE.NOME, E.COLUMN_VALUE);
	CP C %ROWTYPE;
BEGIN
	OPEN C;
	LOOP
		FETCH C INTO CP;
		EXIT WHEN C%NOTFOUND;
		dbms_output.put_line('CPF: ' || CP.CPF || ' NOME: ' || CP.NOME || ' EMAIL: ' || CP.EMAIL || ' DEBITO: ' || CP.TOTAL_DEBITO);
	END LOOP;
	CLOSE C;
END;
--##




--05	OK
ALTER TYPE CLIENTE_TY
	DROP CONSTRUCTOR FUNCTION CLIENTE_TY(SELF IN OUT NOCOPY CLIENTE_TY, CODIGO_IN NUMBER, CPF_IN NUMBER, NOME_IN VARCHAR2) RETURN SELF AS RESULT CASCADE;
	
ALTER TYPE CLIENTE_TY
	ADD CONSTRUCTOR FUNCTION CLIENTE_TY(SELF IN OUT NOCOPY CLIENTE_TY, CODIGO_IN NUMBER, CPF_IN NUMBER, NOME_IN VARCHAR2) RETURN SELF AS RESULT CASCADE;

CREATE OR REPLACE TYPE BODY CLIENTE_TY AS
	CONSTRUCTOR FUNCTION CLIENTE_TY(SELF IN OUT NOCOPY CLIENTE_TY, CODIGO_IN NUMBER, CPF_IN NUMBER, NOME_IN VARCHAR2) RETURN SELF AS RESULT IS
	BEGIN
		SELF.CODIGO := CODIGO_IN;
		SELF.CPF := CPF_IN;
		SELF.NOME := NOME_IN;
		SELF.ENDERECO := NULL;
		SELF.EMAILS := NULL;
		SELF.SEXO := NULL;
		SELF.PROFISSAO := NULL;
		SELF.BONUS := NULL;
		SELF.TELEFONES := NULL;
		RETURN;
	END;
END;
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

ALTER TYPE CLIENTE_TY
    DROP MEMBER PROCEDURE ALUGARFILME (CODIGO_FILME IN NUMBER) CASCADE;

ALTER TYPE CLIENTE_TY
    ADD MEMBER PROCEDURE ALUGARFILME (CODIGO_FILME IN NUMBER) CASCADE;

CREATE OR REPLACE TYPE BODY CLIENTE_TY AS
    MEMBER PROCEDURE ALUGARFILME (CODIGO_FILME IN NUMBER)  IS 
    BEGIN
        INSERT INTO TABLE(
		   SELECT C.EMPRESTIMOS
		   FROM CLIENTES_INFO_TB C
		   where C.CLIENTE.CODIGO = SELF.CODIGO
				) values(
					emprestimo_ty(
					   '16/01/2009',
					   '18/01/2009',
					   7.00,
					   1.50,
					   1,
					   (select ref(e) from filmes_tb e where e.codigo=CODIGO_FILME)
					)
		
        );
        dbms_output.put_line('EMPRESTIMO DO FILME DE CODIGO: '|| CODIGO_FILME || ' EFETUADO COM SUCESSO');
    END;
END;

--##




--09  

ALTER TYPE CLIENTE_TY
    DROP STATIC PROCEDURE EXIBEDIVIDASCLIENTES  CASCADE;

ALTER TYPE CLIENTE_TY
    ADD STATIC PROCEDURE EXIBEDIVIDASCLIENTES CASCADE;

CREATE OR REPLACE TYPE BODY CLIENTE_TY AS
    STATIC PROCEDURE EXIBEDIVIDASCLIENTES  AS
	CURSOR C IS
	   SELECT c.cliente.nome as NOME_CLIENTE, SUM(e.VALOR_MULTA + e.VALOR_EMPRESTIMO) AS TOTAL_DEVIDO
       FROM CLIENTES_INFO_TB C, TABLE(C.EMPRESTIMOS) E
       group by c.cliente.nome;
	CP C %ROWTYPE;   
    BEGIN
	  OPEN C;
	  LOOP
		FETCH C INTO CP;
		EXIT WHEN C%NOTFOUND;
	     dbms_output.put_line('NOME DO CLIENTE: '|| CP.NOME_CLIENTE || ' VALOR DEVIDO: '|| CP.TOTAL_DEVIDO);
      
	  END LOOP;
	  CLOSE C;	
    END;

	   
--##





--10
--CRIACAO DO INSTANCE METHOD

ALTER TYPE CLIENTE_TY
    DROP MEMBER PROCEDURE RESERVA FILME;

ALTER TYPE CLIENTE_TY
    ADD MEMBER PROCEDURE  RESERVA FILME;

CREATE OR REPLACE TYPE BODY CLIENTE_TY IS
    PROCEDURE RESERVA FILME(SELF.CODIGO NUMBER) AS LANGUAGE JAVA
    NAME 'ExecutarInsert.reservarFilme(double)';
END;

-- CONSULTA A SER USADA NA CLASSE JAVA (FAZ A RESERVA DE UM FILME)

INSERT INTO TABLE(
   SELECT C.RESERVAS
   FROM CLIENTES_INFO_TB C
   where C.CLIENTE.CODIGO = 1
) values(
    reserva_ty(
     (SELECT SYSDATE FROM DUAL) ,
     (SELECT SYSDATE + 3 FROM DUAL) ,
     (SELECT REF(F) FROM FILMES_TB F WHERE F.CODIGO=5)
    )
);

--Classe java

import java.sql.*;
import sqlj.runtime.ref.DefaultContext;
import oracle.sqlj.runtime.Oracle;


public class ExecutarInsert
{
  public static void reservarFilme (double codigo) throws SQLException
  {
     int codigoAux = (int) codigo;
    try{
		Oracle.connect("jdbc:oracle:orcl:@localhost:5521:sol2", "system", "root");
		#sql { 
		"INSERT INTO TABLE(SELECT C.RESERVAS FROM CLIENTES_INFO_TB C  where C.CLIENTE.CODIGO =" +codigoAux +"
			   ) values(
						reserva_ty(
						 (SELECT SYSDATE FROM DUAL) ,
						 (SELECT SYSDATE + 3 FROM DUAL) ,
						 (SELECT REF(F) FROM FILMES_TB F WHERE F.CODIGO=5)
						)
			   ); "

		}; //fim do sql 
		
	}catch(SQLException e){
		System.out.println("Erro na consulta");
	}
  }
}

--##



--11


ALTER TYPE FORNECEDOR_TY
    DROP MEMBER PROCEDURE ENGLISHCATEGORY CASCADE;

ALTER TYPE FORNECEDOR_TY
    ADD MEMBER PROCEDURE ENGLISHCATEGORY CASCADE;



CREATE OR REPLACE TYPE BODY FORNECEDOR_TY AS
    MEMBER PROCEDURE ENGLISHCATEGORY   AS
	CURSOR C IS
	   SELECT DISTINCT(F.FILME.CATEGORIA)  AS ENGCATEGORY FROM FILMES_INFO_TB F
       WHERE F.FORNECEDOR.CODIGO=SELF.CODIGO;
	CP C %ROWTYPE;   
    BEGIN
	  OPEN C;
	  LOOP
		FETCH C INTO CP;
		EXIT WHEN C%NOTFOUND;
	      IF UPPER(CP.ENGCATEGORY) = 'FIM DOS TEMPOS' THEN
		     DBMS_OUTPUT.PUT_LINE('CATEGORIA EM INGLES: Doomsday');
		  ELSIF UPPER(CP.ENGCATEGORY) = 'TERROR' THEN
		     DBMS_OUTPUT.PUT_LINE('CATEGORIA EM INGLES: Terror');
		  ELSIF UPPER(CP.ENGCATEGORY) = 'DRAMA' THEN
		    DBMS_OUTPUT.PUT_LINE('CATEGORIA EM INGLES: Drama');
		  ELSIF UPPER(CP.ENGCATEGORY) = 'COMEDIA' THEN
		    DBMS_OUTPUT.PUT_LINE('CATEGORIA EM INGLES: COMEDY');	
		  ELSE 
		    DBMS_OUTPUT.PUT_LINE('CATEGORIA EM INGLES: Action');
          END IF;
	  END LOOP;
	  CLOSE C;	
    END;
	
	
--NAO SEI SE FUNCIONA ASSIM TEM QUE TESTAR, AQUI DEU ERRO	
       DECLARE
         FORNECEDOR FORNECEDOR_TY;
       BEGIN 
               SELECT VALUE(F) INTO FORNECEDOR 
			   FROM FORNECEDOR_TY F
			   WHERE F.CODIGO = 101;
               FORNCECEDOR.ENGLISHCATEGORY ();
       END;	
	
	
--Fim dos tempos
--Terror
--Drama
--Comedia
--Acao


--##



--******CONSIDERAR OS DADOS DOS INSERTS.SQL INICIAL A PARTIR DAQUI*******

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


--Resultado
--FILME	NUM_ALUGUEIS
--O mascara 2	2
--O mascara	1
--Troia	1
--Jogos mortais	1


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
--NOME_CLIENTE	TELEFONES	EMAILS
--Luiz Gonzaga	05508333333333	lg@gmail.com
--Luiz Gonzaga	05508388888888	lg2@gmail.com
--Luiz Gonzaga	05508333333333	lg2@gmail.com
--Luiz Gonzaga	05508388888888	lg@gmail.com
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