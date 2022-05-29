#include <iostream>
#include "dependencies/include/libpq-fe.h"
#include <fstream>
#include <string>
#include <cstring>

PGconn* connect(const char* connInfo);
void abort(PGconn* conn = nullptr, PGresult* res = nullptr);
char menu(const char* connInfo);

void fprint(PGresult *res, const std::string& nome_file, const std::string& path = "");
PGresult* execute(PGconn* conn, const char* query);
void printSeparator(int campi, int* maxChar);
void printQuery(PGresult* res);
std::string queryReader(const std::string& path, const std::string& nome_file);

int main()
{
    const std::string USER = "user=postgres";
    const std::string PASSWORD = "password=basi2022";
    const std::string NOME_DB = "dbname=cineplace+";
    const std::string HOST = "host=192.168.1.210";
    const std::string PORT = "port=5432";
    const std::string blank = " ";                                                                          //i vari parimetri per la connessione devono essere separati da un black space
    
    std::cout << "Premi q per terminare il programma\n";

    std::string s = USER + blank + PASSWORD + blank + NOME_DB + blank + HOST;
    const char* connInfo = s.c_str();                                                                       // string ---> char* 
    
    char scelta = '0';
    while(scelta != 'q'){
         scelta = menu(connInfo);
    }
    return 0;
}

void abort(PGconn* conn , PGresult* res ){

    if (res != nullptr)
        PQclear(res);

    if (conn != nullptr)
        PQfinish(conn);
}


char menu(const char* connInfo){
    std::cout<<"\n\t MENU \n";
    std::cout<<"1) Reset tabelle 1 \n";
    std::cout<<"2) Insert dati nelle tabelle 1 \n";
    std::cout<<"3) Mostra il numero di biglietti comprati da una persona mostrando nome cognome e cf ed evidenzia se puo' fare o meno recensioni \n";
    std::cout<<"4) Mostrare tutti i cinema con incassi totali maggiori di 100$ \n";
    std::cout<<"5) Trovare tutte le persone che si sono sedute sullo stesso posto (anche in sale diverse) \n";
    std::cout<<"6) Trovare le sole persone che non hanno scritto una recensione \n";
    std::cout<<"7) Trovare l'utente che ha acquistato più biglietti con il loro relativo numero \n";
    std::cout<<"8) Trovare tutti i cinema e le relative sale che riproducono il film \"Avengers: Endgame\" \n";
    char scelta;
    std::cin>>scelta;

    switch(scelta){
        case '1':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "create_tables").c_str());
                abort(conn , res);
            }
            break; 
        case '2':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "insert_tuples").c_str());
                abort(conn , res);
            }
            break;
        case '3':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "query1").c_str());
                printQuery(res);
                abort(conn , res);
            }
            break; 
        case '4':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "query2").c_str());
                printQuery(res);
                abort(conn , res);
            }
            break;
        case '5':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "query3").c_str());
                printQuery(res);
                abort(conn , res);
            }
            break; 
        case '6':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "query4").c_str());
                printQuery(res);
                abort(conn , res);
            }
            break;
        case '7':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "query5").c_str());
                printQuery(res);
                abort(conn , res);
            }
            break; 
        case '8':
            {
                PGconn* conn = connect(connInfo);
                PGresult* res = execute(conn,queryReader("", "query6").c_str());
                printQuery(res);
                abort(conn , res);
            }
            break;
        case 'q':
            std::cout << "quitting" << std::endl;
            return scelta;
            break;
        default:
            std::cout << "Input Invalido" << std::endl;
            break;
        }
    return scelta;
}

PGconn* connect(const char* connInfo){
    PGconn* conn = PQconnectdb(connInfo);//connettiti al db
        if (PQstatus(conn) == CONNECTION_BAD){
            std::cerr <<"Connection to database failed:" << PQerrorMessage(conn);   //verifica la connessione
            abort(conn);
        }
    return conn;
}

PGresult* execute(PGconn* conn, const char* query) {

    PGresult* res = PQexec(conn, query);
    ExecStatusType status = PQresultStatus(res);
    switch(status){
        case PGRES_EMPTY_QUERY:
            {
                std::cout << "Query inviata vuota\n";
            }
            break; 
        case PGRES_COMMAND_OK:
            {
                std::cout << "Comando andato a buon fine\n";
            }
            break;
        case PGRES_TUPLES_OK:
            {
                std::cout << "Risultato delle tuple consistente\n";
            }
            break;
        case PGRES_COPY_OUT:
            {
                std::cout << "PGRES_COPY_OUT\n";
            }
            break;
        case PGRES_COPY_IN:
            {
                std::cout << "PGRES_COPY_IN\n";
            }
            break;
        case PGRES_BAD_RESPONSE:
            {
                std::cout << "PGRES_BAD_RESPONSE\n";
                abort(conn , res);
                exit(1);
            }
            break;
        case PGRES_NONFATAL_ERROR:
            {
                std::cout << "PGRES_NONFATAL_ERROR\n";
                abort(conn , res);
                exit(1);
            }
            break;
        case PGRES_FATAL_ERROR:
            {
                std::cout << "PGRES_FATAL_ERROR\n";
                abort(conn , res);
                exit(1);
            }
            break;
    }

    return res;
}

void fprint(PGresult *res, const std::string& nome_file, const std::string& path){
    std::ofstream file (path+nome_file+".csv");     //definisci file stream dove mettere la stampa della query
    int tuple = PQntuples(res);                     //conta tuple
    int campi = PQnfields(res);                     //conta colonne

    for (int i = 0; i < campi; i++){
        file << PQfname(res, i) << ",";
    }
    file << std::endl;
    
    for (int i = 0; i < tuple; i++){
        for (int j = 0; j < campi; j++){
            file << PQgetvalue(res, i, j) << ",";
        }
        file << std::endl;
    }
    file.close();
}

void printSeparator(int campi, int* maxChar) {
    for (int j = 0; j < campi; ++j) {
        std::cout << '+';
        for (int k = 0; k < maxChar[j] + 2; ++k)
            std::cout << '-';
    }
    std::cout << "+\n";
}

void printQuery(PGresult* res) {
    // Preparazione dati
    int tuple = PQntuples(res), campi = PQnfields(res);
    std::string v[tuple + 1][campi];

    for (int i = 0; i < campi; ++i) {
        std::string s = PQfname(res, i);
        v[0][i] = s;
    }
    for (int i = 0; i < tuple; ++i)
        for (int j = 0; j < campi; ++j) {
            if (std::string(PQgetvalue(res, i, j)) == "t" || std::string(PQgetvalue(res, i, j)) == "f")
                if (std::string(PQgetvalue(res, i, j)) == "t")
                    v[i + 1][j] = "si";
                else
                    v[i + 1][j] = "no";
            else
                v[i + 1][j] = PQgetvalue(res, i, j);
        }

    int maxChar[campi];
    for (int i = 0; i < campi; ++i)
        maxChar[i] = 0;

    for (int i = 0; i < campi; ++i) {
        for (int j = 0; j < tuple + 1; ++j) {
            int size = v[j][i].size();
            maxChar[i] = size > maxChar[i] ? size : maxChar[i];
        }
    }

    // Stampa effettiva delle tuple
    printSeparator(campi, maxChar);
    for (int j = 0; j < campi; ++j) {
        std::cout << "| ";
        std::cout << v[0][j];
        for (int k = 0; k < maxChar[j] - v[0][j].size() + 1; ++k)
            std::cout << ' ';
        if (j == campi - 1)
            std::cout << "|";
    }
    std::cout << std::endl;
    printSeparator(campi, maxChar);

    for (int i = 1; i < tuple + 1; ++i) {
        for (int j = 0; j < campi; ++j) {
            std::cout << "| ";
            std::cout << v[i][j];
            for (int k = 0; k < maxChar[j] - v[i][j].size() + 1; ++k)
                std::cout << ' ';
            if (j == campi - 1)
                std::cout << "|";
        }
        std::cout << std::endl;
    }
    printSeparator(campi, maxChar);
}

std::string queryReader(const std::string& path, const std::string& nome_file){
    std::ifstream file(path+nome_file+".sql");
    std::string s = "";
    while (!file.eof()){
        std::string line;
        std::getline(file,  line);
        s.append(line);
    }
    file.close();
    return s;
}