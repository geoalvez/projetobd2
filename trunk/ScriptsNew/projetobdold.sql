


   CREATE TYPE FILME as object
   ( codigo NUMBER,
     titulo VARCHAR2(50),
     ano NUMBER,
     categoria VARCHAR(30),
     num_oscars NUMBER,
     descricao VARCHAR(150),
     duracao_min NUMBER
   );

  create table FILMES of FILME
   (codigo      primary key ); 
   


     CREATE TYPE ENDERECO as OBJECT
     ( rua VARCHAR2(30),
       numero INTEGER,
       bairro VARCHAR2(20),
       cidade VARCHAR2(15),
       estado VARCHAR2(2),
       cep VARCHAR2(10)
     );


    create table ENDERECOS of ENDERECO;


   
    CREATE TYPE TELEFONE as OBJECT
    (
      codigo NUMBER,
      codigoPais NUMBER,
      ddd NUMBER,
      numero NUMBER
    );

   create table TELEFONES of TELEFONE
   (codigo      primary key );
   

    CREATE TYPE LISTA_TELEFONES AS VARRAY(5) OF TELEFONE;

    CREATE TYPE EMAILS AS VARRAY(5) OF VARCHAR2(30);


   CREATE TABLE TELEFONES_TB of TELEFONE;

CREATE TYPE EMAILS as VARRAY(10) OF VARCHAR(30);
  
   CREATE TABLE EMAILS_TB of EMAILS;   

    CREATE TYPE DEPENDENTE as OBJECT
    ( codigo NUMBER,
      nome VARCHAR2(50),
      endereco ENDERECO,
      emails EMAILS,
      sexo VARCHAR2(3),
      telefones LISTA_TELEFONES
    );

    create table DEPENDENTES of DEPENDENTE
   (codigo      primary key ); 
 
  

  

   CREATE TYPE IDIOMAS as VARRAY(10) OF VARCHAR(30);

   CREATE TABLE IDIOMAS_TB of IDIOMAS;

   CREATE TYPE ESPECIALIDADES as VARRAY(10) OF VARCHAR(30);
 
   CREATE TABLE ESPECIALIDADES_TB of ESPECIALIDADES;
  
   CREATE TYPE CATEGORIAS as VARRAY(10) OF VARCHAR(30);

   CREATE TABLE CATEGORIAS_TB of CATEGORIAS;

 

  


//Deseja-se armazenar os empréstimos de cada cliente e o perfil dos mesmos (opiniões sobre os filmes vistos e quais categorias ele prefere), o //empréstimo deverá conter a data de empréstimo, a data de entrega e o valor da multa (se existir) e se a multa foi paga ou não.


CREATE TYPE PERFIL_EMPRESTIMO as OBJECT

(

   codigo NUMBER,

   opiniao VARCHAR2(200),

   categorias REF CATEGORIAS
);


create table PERFIL_EMPRESTIMOS of PERFIL_EMPRESTIMO
   (codigo      primary key ); 


CREATE TYPE EMPRESTIMO as OBJECT

(  codigo NUMBER,

   data_emprestimo DATE,

   data_entrega DATE,

   valor_multa NUMBER(5,2),

   multa_paga BOOLEAN,

  perfil_emprestimo REF PERFIL_EMPRESTIMO

);


create table EMPRESTIMOS of EMPRESTIMO
   (codigo      primary key );






//Deve-se permitir que os clientes reservem filmes, contendo a data da reserva e //até quando eles podem aguardar pelo filme.


CREATE TYPE RESERVA as OBJECT

(

   codigo NUMBER,

   filme REF Filme,

   data_da_reserva DATE,

   data_limite_espera DATE
);

create table RESERVAS of RESERVA
   (codigo      primary key );

//nome, CPF, endereço(rua, número, bairro, cidade, estado), emails, sexo, profissão, bônus (int), telefones (Cod Pais + DDD + número) (até 5)).

   CREATE TYPE CLIENTE as OBJECT
   ( codigo NUMBER,
     nome VARCHAR2(100),
     cpf    VARCHAR2(14),
     endereco REF ENDERECO,
     emails REF EMAILS,
     sexo VARCHAR2(3),
     profissao VARCHAR(50),
     bonus NUMBER,
     telefones REF TELEFONES,
     dependentes REF DEPENDENTES_NT,
     reservas REF RESERVAS_NT,
     emprestimos REF EMPRESTIMOS
   );

   


   CREATE TYPE DEPENDENTES_NT AS TABLE OF DEPENDENTE;
   CREATE TYPE RESERVAS_NT AS TABLE OF RESERVA;
   CREATE TYPE EMPRESTIMOS_NT AS TABLE OF EMPRESTIMO;

   CREATE TABLE CLIENTES of CLIENTE
  ( codigo     primary key ,
    dependentes DEPENDENTE_NT,
    reservas RESERVAS_NT,
    emprestimos EMPRESTIMOS_NT)
    NESTED TABLE dependentes STORE as dependentes_st
    NESTED TABLE emprestimos STORE as emprestimos_st
    NESTED TABLE reservas STORE as reservas_st;
   


  

//Para DVD temos informações sobre a zona e idiomas, além do fabricante; e para fita VHS temos informação sobre data de gravação da fita além do fabricante. 



CREATE TYPE VHS
    UNDER FILME (
    data_gravacao DATE,
    fabricante VARCHAR2(50))
    NOT FINAL;


create table VHSS of VHS;



CREATE TYPE DVD
    UNDER FILME (
    zona VARCHAR2(50),
    fabricante VARCHAR2(50),

    idiomas REF IDIOMAS)
    NOT FINAL;


create table DVDS of DVD;




//Deseja-se também cadastrar informação sobre os profissionais - atores e diretores que atuaram em cada filme. Para cada profissional necessita-se //do seu nome, emails e endereço.

//Especificamente para atores deseja-se saber quantos Oscars já ganhou. Com relação a diretor deseja-se informar suas especialidades (fotografia, //roteiro, geral, dentre outras).


CREATE TYPE PROFISSIONAL as OBJECT

(

codigo NUMBER,

nome VARCHAR(100),

emails REF EMAILS,

endereco REF ENDERECO,

);



create table PROFISSIONAIS of PROFISSIONAL
   (codigo      primary key );


CREATE TYPE ATOR
    UNDER PROFISSIONAL (
    num_oscars NUMBER)
    NOT FINAL;


create table ATORES of ATOR;


CREATE TYPE DIRETOR
    UNDER PROFISSIONAL (

    especialidades REF ESPECIALIDADES)
    NOT FINAL;

create table DIRETORES of DIRETOR;



//A locadora também mantém um cadastro de seus fornecedores de filme. Para cada fornecedor, existe informação sobre nome, endereço, telefones, email), como também quais categorias de filme aquele fornecedor fornece.


CREATE TYPE FORNECEDOR as OBJECT

(

   nome VARCHAR2(50),

   endereco REF ENDERECO,

   telefones REF TELEFONES,

   emails REF EMAILS,

   categorias REF CATEGORIAS

);

