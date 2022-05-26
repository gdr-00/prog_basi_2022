drop table if exists recensione_sala;
drop table if exists recensione_film;
drop table if exists biglietto;
drop table if exists account;
drop table if exists programmazione;
drop table if exists persona;
drop table if exists sala;
drop table if exists cinema;
drop table if exists film;

create table film (
    nome_film           varchar (100),
    anno_uscita         date,
    durata              time    not null,
    valutazione_media   numeric(2,1),
    primary key(nome_film, anno_uscita)
);

create table cinema (
    nome            varchar(50),
    citta           varchar(50),
    incassi_totali  varchar(100),
    via             varchar(50) not null,
    numero          char(5)     not null,
    cap             char(5)     not null,
    stato           varchar(30) not null,
    primary key(nome, citta)
);

create table sala (
    numero_sala         char(2),
    nome_cinema         varchar(50),
    citta_cinema        varchar(50),
    posti_massimi       varchar(10),
    prezzo              money,
    valutazione_media   numeric(3,1),
    primary key(numero_sala,nome_cinema,citta_cinema),
    foreign key(nome_cinema, citta_cinema) references cinema(nome, citta) on update cascade on delete cascade
);

create table persona (
    CF              char(16) primary key,
    nome            varchar(50),
    cognome         varchar(50),
    sesso           char(2),
    data_nascita    date,
    numero_telefono varchar(15)
);

create table account (
    email       varchar(50) primary key,
    password    varchar(50),
    cf          char(16),
    premium     boolean,
    foreign key(cf) references persona(cf) on update cascade
);

create table recensione_sala (
    data            timestamp,
    email           varchar(50) default 'utente_eliminato',
    commento        varchar(500),
    valutazione     numeric(1),
    primary key(data, email),
    foreign key(email) references account(email) on update cascade on delete set default
);

create table recensione_film (
    data            timestamp,
    email           varchar(50) default 'utente_eliminato',
    commento        varchar(500),
    valutazione     numeric(1),
    primary key(data, email),
    foreign key(email) references account(email) on update cascade on delete set default
);

create table biglietto (
    biglietto_id    bigserial   primary key,
    data_acquisto   timestamp   not null,
    nome_film       varchar(50) not null,
    anno_uscita     date        not null,
    numero_sala     char(2),
    nome_cinema     varchar(50),
    citta_cinema    varchar(50),
    email           varchar(50),
    posto           smallint    not null,
    foreign key(nome_film,anno_uscita) references film(nome_film, anno_uscita) on update cascade,
    foreign key(numero_sala,nome_cinema,citta_cinema) references sala(numero_sala, nome_cinema, citta_cinema) on update cascade on delete set null,
    foreign key(email) references account(email) on update cascade on delete set null
);

create table programmazione (
    nome_film       varchar (100),
    anno_uscita     date,
    numero_sala     char(2),
    nome_cinema     varchar(50),
    citta_cinema    varchar(50),
    orario          time not null,
    primary key(orario, nome_film, anno_uscita, numero_sala, nome_cinema, citta_cinema),
    foreign key(nome_film, anno_uscita) references film(nome_film,anno_uscita) on update cascade,
    foreign key(nome_cinema,citta_cinema, numero_sala) references sala(nome_cinema,citta_cinema,numero_sala)
);

INSERT INTO ACCOUNT (email, password, cf, premium) VALUES
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