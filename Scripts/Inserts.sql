ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY' ;


--filmes

delete from filmes_tb;

insert into filmes_tb values(
FILME_TY
    (   1,
        'Titanic',
        1997,
        'Drama',
        11,
        'Era uma vez um navio que desafiou os mares',
        194
    ) 
);

insert into filmes_tb values(
FILME_TY
    (  2,
        '2012',
        2009,
        'Fim dos tempos',
        4,
        'aqui é a descrição',
        160
    )
);

insert into filmes_tb values(	
 FILME_TY
    (   3,
        'Troia',
        2004,
        'Acao',
        1,
        'Cavalo de Troia',
        90
    )
);

insert into filmes_tb values(
	FILME_TY
    (   4,
        'Jogos mortais',
        1997,
        'Terror',
        11,
        'Era uma vez uma noite de terror',
        194
    )
);

insert into filmes_tb values(
FILME_TY
    ( 5,
        'O mascara',
        1997,
        'Comedia',
        11,
        'Era uma vez o mascara',
        194
    )
);
	
insert into filmes_tb values(
FILME_TY
    ( 6,
        'O mascara 2',
        1997,
        'Comedia',
        11,
        'Era uma vez o mascara 2',
        194
    )
);

delete from fornecedores_tb;

insert into fornecedores_tb values(
FORNECEDOR_TY
    ( 1,
        'Warner Bros',
        ENDERECO_TY
            (
                'Rua de nw',
                34,
                'Broklin 1',
                'New York',
                'NY'
            ),
         EMAILS_TY
            (
                'wb@gmail.com'
            ),
		TELEFONES_TY('05508333333333', '05508388888888')
    )
);

insert into fornecedores_tb values(
FORNECEDOR_TY
    ( 2,
        'Fox Filmes',
         ENDERECO_TY
            (
                'Rua de Hollywood',
                4332,
                'Broklin 2',
                'Los Angeles',
                'PS'
            ),
         EMAILS_TY
            (
                'ff@gmail.com'
            ),
		TELEFONES_TY('05508333333333', '05508388888888')
    )
);

insert into fornecedores_tb values(
FORNECEDOR_TY
    ( 3,
        'Universal Filmes',
        ENDERECO_TY
            (
                'Rua de Washington',
                333,
                'Broklin 3',
                'Washington',
                'PS'
            ),
         EMAILS_TY
            (
                'ff@gmail.com'
            ),
		TELEFONES_TY('05508333333333', '05508388888888')
    )
);


delete from filmes_info_tb;

insert into filmes_info_tb values(
  (select ref(e) from filmes_tb e where e.codigo=1),
  (select ref(e) from fornecedores_tb e where e.codigo=1),
  PROFISSIONAIS_NT
  (
	DIRETOR_TY
     (   1,
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
         (   2,
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
        (   3,
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
        (   4,
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

insert into filmes_info_tb values(
  (select ref(e) from filmes_tb e where e.codigo=2),
  (select ref(e) from fornecedores_tb e where e.codigo=1),
  PROFISSIONAIS_NT
    (DIRETOR_TY
        (   5,
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
        (   6,
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

insert into filmes_info_tb values(
  (select ref(e) from filmes_tb e where e.codigo=3),
  (select ref(e) from fornecedores_tb e where e.codigo=2),
  PROFISSIONAIS_NT
    (DIRETOR_TY
        (   7,
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
        (   8,
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

insert into filmes_info_tb values(
  (select ref(e) from filmes_tb e where e.codigo=4),
  (select ref(e) from fornecedores_tb e where e.codigo=2),
  PROFISSIONAIS_NT
    (
	DIRETOR_TY
        (   9,
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
        (   10,
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
        (   11,
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
        (   12,
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

insert into filmes_info_tb values(
  (select ref(e) from filmes_tb e where e.codigo=5),
  (select ref(e) from fornecedores_tb e where e.codigo=3),
  PROFISSIONAIS_NT
  (
	    DIRETOR_TY
        (   13,
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
        (   14,
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
        (   15,
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

insert into filmes_info_tb values(
  (select ref(e) from filmes_tb e where e.codigo=6),
  (select ref(e) from fornecedores_tb e where e.codigo=3),
  PROFISSIONAIS_NT
    (   
	     DIRETOR_TY
        (   16,
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
        (   17,
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
        (   18,
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

delete from clientes_tb;

insert into clientes_tb values(
     cliente_ty
	 (
	     1,
		 'Jackson do Pandeiro',
		 99999999999,
		 ENDERECO_TY
            (
                'Rua do Forró',
                13,
                'Capoeiras',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'jpandeiro@gmail.com', 'jp@gmail.com'
            ),
		'M',
		'Forrozeiro',
		4.00,
		TELEFONES_TY('05508333333333', '05508388888888')
	 )
);

insert into clientes_tb values(
     cliente_ty
	 (
	     2,
		 'Luiz Gonzaga',
		 88888888888,
		 ENDERECO_TY
            (
                'Rua do Forró 2',
                13,
                'Capoeiras 2',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'lg@gmail.com', 'lg2@gmail.com'
            ),
		'M',
		'Forrozeiro',
		4.00,
		TELEFONES_TY('05508333333333', '05508388888888')
	 )
);

insert into clientes_tb values(
     cliente_ty
	 (
	     3,
		 'Marinez',
		 77777777777,
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'm@gmail.com', 't@gmail.com'
            ),
		'F',
		'Forrozeiro',
		2.00,
		TELEFONES_TY('05508333333333', '05508388888888')
	 )
);

delete from CLIENTES_INFO_TB;

insert into CLIENTES_INFO_TB values (
	(select ref(e) from clientes_tb e where e.codigo=1),
	DEPENDENTES_NT(
	   dependente_ty(
	     'Fernando Fagundes',
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'fernandof@gmail.com'
            ),
		'M',
		TELEFONES_TY('05508333333333', '05508388888888')
	  ),
	  dependente_ty(
	     'Jeysibel da silva',
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'jeysibel@gmail.com'
            ),
		'M',
		TELEFONES_TY('05508333333333', '05508388888888')
	  )
	  
	),
	EMPRESTIMOS_NT(
	  emprestimo_ty(
	   '10/01/2009',
	   '12/01/2009',
	   1.50,
	   0,
	   (select ref(e) from filmes_tb e where e.codigo=4)
	  ) ,
	   emprestimo_ty(
		   '16/12/2008',
		   '18/12/2008',
		   1.50,
		   0,
		   (select ref(e) from filmes_tb e where e.codigo=6)
		)
	   
	  
	),
	RESERVAS_NT(
	     reserva_ty(
		     '01/01/2007',
			 '10/01/2007',
			 (select ref(e) from filmes_tb e where e.codigo=1)
		 ),
		 
		  reserva_ty(
		     '20/01/2006',
			 '30/01/2006',
			 (select ref(e) from filmes_tb e where e.codigo=2)
		 )
		 
		 
	
	
	),
    OPINIOES_NT()
);

insert into CLIENTES_INFO_TB values (
	(select ref(e) from clientes_tb e where e.codigo=2),
	DEPENDENTES_NT(
	    dependente_ty(
	     'Romeryto Lira',
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'romeryto@gmail.com'
            ),
		'M',
		TELEFONES_TY('05508333333333', '05508388888888')
	  ),
	  dependente_ty(
	     'Maria do Bairro',
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'mariab@gmail.com'
            ),
		'F',
		TELEFONES_TY('05508333333333', '05508388888888')
	  )
	
	),
	EMPRESTIMOS_NT(
		emprestimo_ty(
		   '12/02/2009',
		   '14/02/2009',
		   1.50,
		   0,
		   (select ref(e) from filmes_tb e where e.codigo=5)
		),
		
		emprestimo_ty(
		   '16/01/2009',
		   '18/01/2009',
		   1.50,
		   0,
		   (select ref(e) from filmes_tb e where e.codigo=6)
		 )
		 ,
		 
		 emprestimo_ty(
		   '05/04/2009',
		   '18/04/2009',
		   1.50,
		   0,
		   (select ref(e) from filmes_tb e where e.codigo=3)
		 )
	 
	 ),
	   
	RESERVAS_NT(
	   reserva_ty(
		     '02/02/2009',
			 '10/02/2009',
			 (select ref(e) from filmes_tb e where e.codigo=3)
		 ),
		  reserva_ty(
		     '01/01/2008',
			 '10/01/2008',
			 (select ref(e) from filmes_tb e where e.codigo=4)
		 )
	  
	
	),
    OPINIOES_NT()
);



insert into CLIENTES_INFO_TB values (
	(select ref(e) from clientes_tb e where e.codigo=3),
	DEPENDENTES_NT(
	  dependente_ty(
	     'Geo Alvez',
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'galv@gmail.com'
            ),
		'M',
		TELEFONES_TY('05508333333333', '05508388888888')
	  ),
	  dependente_ty(
	     'Adreia Alvez',
		 ENDERECO_TY
            (
                'Rua do Forró3',
                13,
                'Capoeiras3',
                'Cajazeiras',
                'PB'
            ),
         EMAILS_TY
            (
                'andal@gmail.com'
            ),
		'F',
		TELEFONES_TY('05508333333333', '05508388888888')
	  )
	  
	),
	EMPRESTIMOS_NT(),
	   
	RESERVAS_NT(),
    OPINIOES_NT()
);


	


