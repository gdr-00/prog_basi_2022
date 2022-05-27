INSERT INTO persona (CF, nome, cognome, sesso, data_nascita, numero_telefono) VALUES
('BRGGLI78B51M130S','Ludovica','Argurio','F','1974-03-21','+39 0341993996'),
('SLVGBL37D47H270I','Ornella','Sforza','F','1978-08-11','+39 3770587292'),
('ZMNPTZ82H21B629G','Lisa','Babbo','M','1986-08-09','388897923'),
('RFFGTN98C65M260G','Delfino','Zamorani','M','1972-06-04','+39 0825455493'),
('RGRLRT56L24M298J','Michelangelo','Brugnaro','F','2005-06-25','3520407828'),
('CGNVLT50T15G211Y','Federico','Zabarella','M','2009-12-25','073494379'),
('FODMA09D54A347EX','Priscilla','Cattaneo','M','2008-04-02','3780582868'),
('LPPGLR37D07B883S','Carolina','Broggini','F','1999-07-29','+39 0574263625'),
('PRTRSN78H13L359O','Nicola','Zampa','F','2018-12-20','0736377506'),
('BRCGNE08M11M180X','Martina','Boezio','F','2009-06-09','+39 05746151177');

INSERT INTO account (email, password, cf, premium) VALUES
('gian06@hotmail.it','Gj+2PhTc)8','BRGGLI78B51M130S',false),
('paulina13@gmail.com','6i251ZU!$R','SLVGBL37D47H270I', true),
('lucreziacorradi@live.com','61LtXtke_*','ZMNPTZ82H21B629G', true),
('dligorio@hotmail.it','&RGwY^tc3z','RFFGTN98C65M260G', false),
('boccionipietro@tiscali.it','Rm3Oxpvv3$','RGRLRT56L24M298J', true),
('ipiccinni@outlook.com','485GDw^p%)','CGNVLT50T15G211Y', true),
('paoloantonioni@yahoo.com','S1897BnS$(','FODMA09D54A347EX', true),
('piergiorgio37@gmail.com','5L!5iDy4RT','PRTRSN78H13L359O', false),
('mazzacuratimarcantonio@tele2.it','UB$$2gFeew','BRCGNE08M11M180X', true),
('qnonis@vodafone.it','!GRjf6e60#','LPPGLR37D07B883S', false);

INSERT INTO film(nome_film,anno_uscita,durata) VALUES
('Avengers Assemble','2012-03-01','3:20:00'),
('Novgorodtsy','1943-04-11','1:25:00'),
('Avengers: Endgame','2019-06-06','2:30:00'),
('Avengers: Infinity War','2018-04-12','3:50:00'),
('Avengers: Age of Ultron','2015-01-01','1:25:00'),
('Avengers of Justice: Farce Wars','2018-02-01','3:00:00'),
('Crippled Avengers','1978-06-07','0:45:00'),
('The Avengers','1998-07-17','2:52:00'),
('Doctor Strange in the Multiverse of Madness','2022-03-03','1:44:00'),
('The Northman','2022-05-27','1:44:00'),
('Morbius','2022-01-11','1:44:00'),
('Old','2021-04-30','1:44:00'),
('Doctor Strange','2016-09-22','1:44:00');

INSERT INTO cinema(nome,citta,via,numero,cap,stato) VALUES
('Cinema1','Citta1','Via A','1','11111','Italia'),
('Cinema2','Citta2','Via B','2','22222','Italia'),
('Cinema3','Citta3','Via C','3','33333','Italia'),
('Cinema4','Citta4','Via D','4','44444','Italia'),
('Cinema5','Citta5','Via E','5','55555','Italia'),
('Cinema6','Citta6','Via F','6','66666','Italia'),
('Cinema7','Citta7','Via G','7','77777','Italia'),
('Cinema8','Citta8','Via H','8','88888','Italia'),
('Cinema9','Citta9','Via I','9','99999','Italia'),
('Cinema10','Citta10','Via J','10','10101','Italia');

INSERT INTO recensione_film(data, email, commento, valutazione,nome_film, anno_uscita) VALUES
('2022-11-23','paulina13@gmail.com','Explicabo commodi earum aliquid. Debitis deleniti perferendis nisi.','3','Avengers Assemble','2012-03-01'),
('2022-09-18', 'paulina13@gmail.com', 'Illo aliquam deleniti minima dicta.','5','Old','2021-04-30'),
('2022-09-14','paulina13@gmail.com','Aliquam ea optio eius porro. Ea voluptas aspernatur. Eveniet quae a.','5','Avengers: Endgame','2019-06-06'),
('2022-02-24','lucreziacorradi@live.com','Iste facilis fugiat esse perferendis illo. Dolores pariatur inventore dolore suscipit.','4','Avengers Assemble','2012-03-01'),
('2022-07-18','boccionipietro@tiscali.it','Nihil reprehenderit temporibus facere. Nulla dolore consectetur vero earum.','9','Avengers Assemble','2012-03-01'),
('2022-05-14','mazzacuratimarcantonio@tele2.it','Voluptas nisi quo minima quidem amet optio fugit. Asperiores eum adipisci modi voluptatem eum.','4','Avengers Assemble','2012-03-01'),
('2022-11-18','ipiccinni@outlook.com','Magnam assumenda possimus ducimus esse et. Nisi quia iusto recusandae nulla tempora ab.','5','Avengers Assemble','2012-03-01'),
('2022-12-06','ipiccinni@outlook.com','Culpa odio veniam saepe. Aperiam vel accusantium adipisci non quaerat.','4','Old','2021-04-30'),
('2022-05-07','ipiccinni@outlook.com','Dolores eligendi voluptate incidunt doloremque. Vitae quam nostrum ut quisquam.','6','Avengers: Endgame','2019-06-06');