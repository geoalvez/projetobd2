ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY' 

-- inserts novos

                                             
INSERT INTO FILMES_TB VALUES(
'George o Rei da Floresta',
2009,
'Comedia',
15,
'Confusoes tamanho familia',
120
);





insert into FILMES_TB_INFORM values(
  1,
 (select ref(f)from FILMES_TB f where f.TITULO = 'George o Rei da Floresta'),
  PROFISSIONAIS_NT
  (
     DIRETOR_TY
     (   
         'James Cameron',
         ENDERECO_TY
         (
             'Av Buraco da Gia',
             60,
             'Buraco da Gia',
             'Campina Grande',
             'PB'
          ),
          EMAILS_TY
          (
             'jc@gmail.com'
          ),
          ESPECIALIDADES_NT
          (
             'DRAMA'
           )    
      ),
      DIRETOR_TY
         (   
            'John Landau',
            ENDERECO_TY
            (
                'Av Buraco da Gia',
                90,
                'Buraco da Gia',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jlandau@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'DRAMA'
            )    
         ),
        ATOR_TY
        (   
            'George Alves',   
            ENDERECO_TY
            (
                'Rua da Floresta',
                24,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'geo@gmail.com'
            ),
            24
        ),
        ATOR_TY
        (   
            'Gloria Stuart ',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                13,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'leonardo@gmail.com'
            ),
            11
        )
    )
   
);




INSERT INTO FILMES_TB VALUES(
'Lula O Filme',
2009,
'Drama',
15,
'Historia do presidente',
120
);

insert into FILMES_TB_INFORM values(
  2,
 (select ref(f)from FILMES_TB f where f.TITULO = 'Lula O Filme'),
  PROFISSIONAIS_NT
  (
     DIRETOR_TY
     (   
         'James Cameron',
         ENDERECO_TY
         (
             'Av Buraco da Gia',
             60,
             'Buraco da Gia',
             'Campina Grande',
             'PB'
          ),
          EMAILS_TY
          (
             'jc@gmail.com'
          ),
          ESPECIALIDADES_NT
          (
             'DRAMA'
           )    
      ),
      DIRETOR_TY
         (   
            'John Landau',
            ENDERECO_TY
            (
                'Av Buraco da Gia',
                90,
                'Buraco da Gia',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jlandau@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'DRAMA'
            )    
         ),
        ATOR_TY
        (   
            'Luiz Inacio Lula da Silva',   
            ENDERECO_TY
            (
                'Rua Brasilia',
                24,
                'Bodocongo',
                'Brasilia',
                'DF'
            ),
            EMAILS_TY
            (
                'lula@gmail.com'
            ),
            24
        ),
        ATOR_TY
        (   
            'Gloria Stuart ',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                13,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'leonardo@gmail.com'
            ),
            11
        )
    )
   
);



INSERT INTO FILMES_TB VALUES(
'Cavalo de Troia',
2009,
'Aventura',
15,
'Cavalo de Troia',
150
);




--inserts antigos

INSERT INTO FILMES_TB VALUES
(
    1,
    FILME_TY
    (
        'Titanic',
        1997,
        'Drama',
        11,
        'Era uma vez um navio que desafiou os mares',
        194
    ),
    PROFISSIONAIS_NT
    (
        DIRETOR_TY
        (   
            'James Cameron',
            ENDERECO_TY
            (
                'Av Buraco da Gia',
                60,
                'Buraco da Gia',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jc@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'DRAMA'
            )    
        ),
        DIRETOR_TY
        (   
            'John Landau',
            ENDERECO_TY
            (
                'Av Buraco da Gia',
                90,
                'Buraco da Gia',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jlandau@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'DRAMA'
            )    
        ),
        ATOR_TY
        (   
            'Leonardo Di Caprio',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                24,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'leonardo@gmail.com'
            ),
            24
        ),
        ATOR_TY
        (   
            'Gloria Stuart ',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                13,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'leonardo@gmail.com'
            ),
            11
        )
    )         
);
\
INSERT INTO FILMES_TB VALUES
(
    2,
    FILME_TY
    (
        '2012',
        2009,
        'Fim dos tempos',
        4,
        'aqui é a descrição',
        160
    ),
    PROFISSIONAIS_NT
    (
        DIRETOR_TY
        (   
            'John Smith',
            ENDERECO_TY
            (
                'rua da coxinha',
                123,
                'centro',
                'Aliança',
                'PE'
            ),
            EMAILS_TY
            (
                'jj@gmail.com',
                'jown@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'DRAMA'
            )    
        ),
        ATOR_TY
        (   
            'Mary Smith',   
            ENDERECO_TY
            (
                'rua da cocada',
                123,
                'bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'mm@gmail.com',
                'mary@gmail.com'
            ),
            2
        )
    )         
);
\
INSERT INTO FILMES_TB VALUES
(
    3,
    FILME_TY
    (
        'Troia',
        2004,
        'Acao',
        1,
        'Cavalo de Troia',
        90
    ),
    PROFISSIONAIS_NT
    (
        DIRETOR_TY
        (   
            'Diretor de Troia',
            ENDERECO_TY
            (
                'Rua da cidade',
                100,
                'Centro',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'diretordetroia@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'ACAO'
            )    
        ),
        ATOR_TY
        (   
            'John Wayne',
            ENDERECO_TY
            (
                'Wayne Street',
                1000,
                'Downtown',
                'Cajazeiras',
                'PB'
            ),
            EMAILS_TY
            (
                'johnwayne@gmail.com'
            ),
            1
        )
    )         
);
\
INSERT INTO FILMES_TB VALUES
(
    4,
    FILME_TY
    (
        'Jogos mortais',
        1997,
        'Terror',
        11,
        'Era uma vez uma noite de terror',
        194
    ),
    PROFISSIONAIS_NT
    (
        DIRETOR_TY
        (   
            'George Marcelo',
            ENDERECO_TY
            (
                'Av Buraco da Gia',
                60,
                'Buraco da Gia',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'gm@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'Terror'
            )    
        ),
        DIRETOR_TY
        (   
            'Arinaldo da Silva',
            ENDERECO_TY
            (
                'Av Buraco da Gia',
                90,
                'Buraco da Gia',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'ari@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'Terror'
            )    
        ),
        ATOR_TY
        (   
            'Jorge Ter',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                24,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jt@gmail.com'
            ),
            24
        ),
        ATOR_TY
        (   
            'Heverton Stuart ',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                13,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'h@gmail.com'
            ),
            11
        )
    )         
);
\
INSERT INTO FILMES_TB VALUES
(
    5,
    FILME_TY
    (
        'O mascara',
        1997,
        'Comedia',
        11,
        'Era uma vez o mascara',
        194
    ),
    PROFISSIONAIS_NT
    (
        DIRETOR_TY
        (   
            'Claudio Batista',
            ENDERECO_TY
            (
                'Av Joaquim carneiro',
                60,
                'centro',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'gm@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'Comedia'
            )    
        ),
        ATOR_TY
        (   
            'John Wayne',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                24,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jt@gmail.com'
            ),
            2
        ),
        ATOR_TY
        (   
            'Heverton Stuart ',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                13,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'h@gmail.com'
            ),
            11
        )
    )         
);
\
INSERT INTO FILMES_TB VALUES
(
    6,
    FILME_TY
    (
        'O mascara 2',
        1997,
        'Comedia',
        11,
        'Era uma vez o mascara 2',
        194
    ),
    PROFISSIONAIS_NT
    (
        DIRETOR_TY
        (   
            'Claudio Batista',
            ENDERECO_TY
            (
                'Av Joaquim carneiro',
                60,
                'centro',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'gm@gmail.com'
            ),
            ESPECIALIDADES_NT
            (
                'Comedia'
            )    
        ),
        ATOR_TY
        (   
            'John Wayne',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                24,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'jt@gmail.com'
            ),
            5
        ),
        ATOR_TY
        (   
            'Abraao Morais',   
            ENDERECO_TY
            (
                'Rua da Rosquinha',
                13,
                'Bodocongo',
                'Campina Grande',
                'PB'
            ),
            EMAILS_TY
            (
                'h@gmail.com'
            ),
            11
        )
    )         
);


--Não funciona ainda
insert into CLIENTES_TB values(
		1,
		cliente_ty('Arinaldo', endereco_ty('Buraco da gia', 56, 'Campina Grande','PB'), emails_ty('ari@gmail.com','arinaldo@bol.com.br'),
		           'M', 'Programador', 3 , telefones_ty('83-3333-3333','83-8888-8888')
		
		
		),
		DEPENDENTES_NT(
		    dependente_ty('Arinaldo Junior', endereco_ty('Buraco da gia', 56, 'Campina Grande','PB'), emails_ty('arif@gmail.com','arinaldof@bol.com.br'),
		           'M', 'Estudante', 3 , telefones_ty('83-3333-3333','83-8888-8888')
		
		),
		EMPRESTIMOS_NT(
		    emprestimo_ty('20/01/2009','30/01/2009', 2.00, 2.00, select ref(e.filme) from filmes_tb e where e.codigo=1)
		
		),
		RESERVAS_NT(
		    reserva_ty('20/01/2009' , '23/01/2009')
		
		),
		OPINIOES_NT(
		    opiniao_ty('nao gostei desse filme','20/02/2009',select ref(e.filme) from filmes_tb e where e.codigo=1)
		
		)
);






