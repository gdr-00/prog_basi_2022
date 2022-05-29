drop table if exists recensione_sala CASCADE;
drop table if exists recensione_film CASCADE;
drop table if exists biglietto CASCADE;
drop table if exists account CASCADE;
drop table if exists programmazione CASCADE;
drop table if exists persona CASCADE;
drop table if exists sala CASCADE;
drop table if exists cinema CASCADE;
drop table if exists film CASCADE;

create table film (
    nome_film           varchar (100),
    anno_uscita         date,
    durata              time    not null,
    valutazione_media   numeric(2,1) check(valutazione_media>=0) default null,
    primary key(nome_film, anno_uscita)
);

create table cinema (
    nome            varchar(50),
    citta           varchar(50),
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
    tipo_sala           varchar(10),
    valutazione_media   numeric(2,1) check(valutazione_media>=0) default null,
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
    numero_sala     char(2),
    nome_cinema     varchar(50),
    citta_cinema    varchar(50),
    commento        varchar(500) default null,
    valutazione     numeric(1) check(valutazione>=0) not null,
    primary key(data, email),
    foreign key(email) references account(email) on update cascade on delete set default,
    foreign key(numero_sala,nome_cinema,citta_cinema) references sala(numero_sala,nome_cinema,citta_cinema) on update cascade on delete cascade
);

create table recensione_film (
    data            timestamp,
    email           varchar(50) default 'utente_eliminato',
    nome_film       varchar (100),
    anno_uscita     date,
    commento        varchar(500) default null,
    valutazione     numeric(1) check(valutazione>=0) not null,
    primary key(data, email),
    foreign key(email) references account(email) on update cascade on delete set default,
    foreign key(nome_film,anno_uscita) references film(nome_film,anno_uscita) on update cascade
);

create table biglietto (
    biglietto_id    bigserial   primary key,
    data_acquisto   timestamp   not null,
    nome_film       varchar(50) not null,
    anno_uscita     date        not null,
    numero_sala     char(2),
    nome_cinema     varchar(50),
    citta_cinema    varchar(50),
    email           varchar(50) default 'utente_eliminato',
    posto           smallint    not null,
    foreign key(nome_film,anno_uscita) references film(nome_film, anno_uscita) on update cascade,
    foreign key(numero_sala,nome_cinema,citta_cinema) references sala(numero_sala, nome_cinema, citta_cinema) on update cascade on delete set null,
    foreign key(email) references account(email) on update cascade on delete set default
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

DROP VIEW IF EXISTS p_a;
 CREATE VIEW p_a AS
	SELECT p.nome, p.cognome, p.cf, a.email
	FROM persona AS p, account AS a
	WHERE p.cf=a.cf;