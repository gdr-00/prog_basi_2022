//TODO: vedere perche' senza .bat il file .exe non rimane aperto
//      implementare il menu' e metterlo nel main  
#include <iostream>
//#include <libpq-fe.h>
#include "dependencies/include/libpq-fe.h"

void abort(PGconn* conn = nullptr, PGresult* res = nullptr);
void menu();

int main()
{
    const std::string NOME_DB = "dbname=lab3";
    const std::string USER = "user=postgres";
    const std::string PASSWORD = "password=2000";
    const std::string blank = " ";                                                                          //i vari parimetri per la connessione devono essere separati da un black space

//TODO:vedere se si puo' rimuovere la funzione s.data() e buttare tutto dentro come stringa

    std::string s = NOME_DB + blank + USER + blank + PASSWORD;
    const char* t = s.data();                                                                                // string ---> char* 
    
//TODO: fare la funzione per connettersi    
    PGconn* conn = PQconnectdb(t);                                                                          // connessione al db

    if (PQstatus(conn) == CONNECTION_BAD){                                                                  // controllo che tutto sia andato bene
        std::cerr <<"Connection to database failed:" << PQerrorMessage(conn);
        abort(conn);
    }

//TODO: fare una funzione per eseguire le query
    PGresult* res = PQexec(conn, "SELECT * FROM hubs");                                                     //esegui la query

    if(PQresultStatus(res) != PGRES_TUPLES_OK){
        std::cerr << "Non e' stato restituito un risultato" << PQerrorMessage(conn);                        // controllo che non ci siano stati errori
        abort(conn);
    }
//FIXME: FATTA SOLO PER VEDERE CHE FUNZONA -----> SPOILER: FUNZIONA LMAO
    for (int i = 0 ; i < 10 ; ++i)
        std::cout<< PQgetvalue(res,i,0) << std::endl;

    abort(conn,res);
    return 0;

}

void abort(PGconn* conn , PGresult* res ){

    if (res != nullptr)
        PQclear(res);

    if (conn != nullptr)
        PQfinish(conn);

    exit(1);
}


void menu()
{
    std::cout<<"/t MENU /n";
    std::cout<<" 1 - query 1 /n";
    std::cout<<" 2 - query 1 /n";

    int scelta;
    std::cin>>scelta;

    //TODO:da fare tutte le funzioni per l'esecuzione delle query
    switch(scelta){
        case 1: break; 
        case 2: break;
    }

    
}