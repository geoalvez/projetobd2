--
--      DROP TYPES
--
DROP TYPE ENDERECO_TY FORCE;
DROP TYPE TELEFONES_TY FORCE;
DROP TYPE EMAILS_TY FORCE;
DROP TYPE DEPENDENTE_TY FORCE;
DROP TYPE DEPENDENTES_NT FORCE;
DROP TYPE FILME_TY FORCE;
DROP TYPE VHS_TY FORCE;
DROP TYPE IDIOMAS_TY FORCE;
DROP TYPE DVD_TY FORCE;
DROP TYPE EMPRESTIMO_TY FORCE;
DROP TYPE EMPRESTIMOS_NT FORCE;
DROP TYPE CLIENTE_TY FORCE;
DROP TYPE RESERVA_TY FORCE;
DROP TYPE RESERVAS_NT FORCE;
DROP TYPE OPINIAO_TY FORCE;
DROP TYPE OPINIOES_NT FORCE;
DROP TYPE PROFISSIONAL_TY FORCE;
DROP TYPE ATOR_TY FORCE;
DROP TYPE ESPECIALIDADES_NT FORCE;
DROP TYPE DIRETOR_TY FORCE;
DROP TYPE PROFISSIONAIS_NT FORCE;
DROP TYPE FORNECEDOR_TY FORCE;
--
--	CREATE TYPES
--
CREATE TYPE ENDERECO_TY AS OBJECT 
(
	RUA		VARCHAR2(30),
	NUMERO	NUMBER,
	BAIRRO	VARCHAR2(20),
	CIDADE	VARCHAR2(15),
	ESTADO	VARCHAR(2)
);
/
CREATE TYPE TELEFONES_TY AS VARRAY(5) OF VARCHAR2(14);
/
CREATE TYPE EMAILS_TY AS VARRAY(5) OF VARCHAR2(30);
/
CREATE TYPE DEPENDENTE_TY AS OBJECT
(
	NOME		VARCHAR2(50),
	ENDERECO 	ENDERECO_TY,
	EMAILS		EMAILS_TY,
	SEXO		VARCHAR2(1),
	TELEFONES	TELEFONES_TY
);
/
CREATE TYPE DEPENDENTES_NT AS TABLE OF DEPENDENTE_TY;
/
CREATE TYPE FILME_TY AS OBJECT
(
    CODIGO		NUMBER,
	TITULO		VARCHAR2(40),
	ANO			NUMBER,
	CATEGORIA	VARCHAR2(15),
	NUM_OSCARS	NUMBER,
	DESCRICAO	VARCHAR2(100),
	DURACAO		NUMBER
) NOT FINAL;
/
CREATE TYPE VHS_TY UNDER FILME_TY
(
	DATA_GRAVACAO	DATE,
	FABRICANTE		VARCHAR(20)
);
/
CREATE TYPE IDIOMAS_TY AS VARRAY(5) OF VARCHAR2(10);
/
CREATE TYPE DVD_TY UNDER FILME_TY
(
	ZONA	NUMBER,
	IDIOMAS	IDIOMAS_TY
);	
/
CREATE TYPE EMPRESTIMO_TY AS OBJECT
(
	DATA_EMPRESTIMO	DATE,
	DATA_ENTREGA	DATE,
	VALOR_MULTA		NUMBER(5,2),
	MULTA_PAGA		INTEGER,
	FILME			REF FILME_TY
);
/
CREATE TYPE EMPRESTIMOS_NT AS TABLE OF EMPRESTIMO_TY;
/
CREATE TYPE RESERVA_TY AS OBJECT
(
	DATA_RESERVA	DATE,
	DATA_EXPIRACAO	DATE,
	FILME 			REF FILME_TY
);
/
CREATE TYPE RESERVAS_NT AS TABLE OF RESERVA_TY;
/
CREATE TYPE OPINIAO_TY AS OBJECT
(
	OPINIAO			VARCHAR2(100),
	DATA_OPINIAO	DATE,
	FILME			REF FILME_TY
);
/
CREATE TYPE OPINIOES_NT AS TABLE OF OPINIAO_TY;
/
CREATE TYPE CLIENTE_TY AS OBJECT
(
	CODIGO		NUMBER,
	NOME		VARCHAR2(50),
	CPF			NUMBER,
	ENDERECO 	ENDERECO_TY,
	EMAILS		EMAILS_TY,
	SEXO		VARCHAR2(1),
	PROFISSAO	VARCHAR2(15),
	BONUS		INTEGER,
	TELEFONES	TELEFONES_TY
);
/
CREATE TYPE PROFISSIONAL_TY AS OBJECT
(
    CODIGO		NUMBER,
	NOME		VARCHAR2(50),
	ENDERECO 	ENDERECO_TY,
	EMAILS		EMAILS_TY
) NOT FINAL;
/
CREATE TYPE ATOR_TY UNDER PROFISSIONAL_TY
(
	NUM_OSCARS	NUMBER
);
/
CREATE TYPE ESPECIALIDADES_NT AS TABLE OF VARCHAR2(20);
/
CREATE TYPE DIRETOR_TY UNDER PROFISSIONAL_TY
(
	ESPECIALIDADES	ESPECIALIDADES_NT
);
/
CREATE TYPE PROFISSIONAIS_NT AS TABLE OF PROFISSIONAL_TY;
/
CREATE TYPE FORNECEDOR_TY AS OBJECT
(
	CODIGO		NUMBER,
	NOME		VARCHAR2(50),
	ENDERECO 	ENDERECO_TY,
	EMAILS		EMAILS_TY,
	TELEFONES	TELEFONES_TY
);
/
--
--      DROP TABLES
--
DROP TABLE CLIENTES_TB FORCE;
DROP TABLE FILMES_TB FORCE;
DROP TABLE FORNECEDORES_TB FORCE;
DROP TABLE FILMES_INFO_TB FORCE;
DROP TABLE CLIENTES_INFO_TB FORCE;
DROP TABLE FILMES_TB FORCE;
DROP TABLE DEPENDENTES_TB FORCE;
DROP TABLE EMPRESTIMOS_TB FORCE;
DROP TABLE RESERVAS_TB FORCE;
DROP TABLE OPINIOES_TB FORCE;
DROP TABLE PROFISSIONAIS_TB FORCE;


--
--	CREATE TABLES
--
CREATE  TABLE CLIENTES_TB OF CLIENTE_TY
(
	PRIMARY KEY (CODIGO, CPF)
);

CREATE TABLE FILMES_TB OF FILME_TY
(
	PRIMARY KEY (CODIGO)
);
--
CREATE TABLE PROFISSIONAIS_TB OF PROFISSIONAL_TY
(
	PRIMARY KEY (CODIGO)
);
--
CREATE TABLE FORNECEDORES_TB OF FORNECEDOR_TY
(
	PRIMARY KEY (CODIGO)
);


--
CREATE TABLE CLIENTES_INFO_TB
(
	CLIENTE		REF CLIENTE_TY,
	DEPENDENTES	DEPENDENTES_NT,
	EMPRESTIMOS	EMPRESTIMOS_NT,
	RESERVAS	RESERVAS_NT,
	OPINIOES	OPINIOES_NT
)
NESTED TABLE DEPENDENTES STORE AS DEPENDENTES_STB,
NESTED TABLE EMPRESTIMOS STORE AS EMPRESTIMOS_STB,
NESTED TABLE RESERVAS STORE AS RESERVAS_STB,
NESTED TABLE OPINIOES STORE AS OPINIOES_STB;
--
--
CREATE TABLE FILMES_INFO_TB
(
	FILME			REF FILME_TY,
	FORNECEDOR		REF FORNECEDOR_TY,
	PROFISSIONAIS	PROFISSIONAIS_NT
)
NESTED TABLE PROFISSIONAIS STORE AS PROFISSIONAIS_STB;
--