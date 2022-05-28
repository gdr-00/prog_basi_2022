//perche' senza .bat il file .exe non rimane aperto? è un eseguibile senza gui quindi esegue il programma e una volta finito chiude la shell
//implementare il menu' e metterlo nel main  
#include <iostream>
#include "dependencies/include/libpq-fe.h"
#include <fstream>
#include <string>
#include <cstring>
#include <vector>

PGconn* connect(const char* connInfo);
void abort(PGconn* conn = nullptr, PGresult* res = nullptr);
void menu(const char* connInfo);

void fprint(PGresult *res, const std::string& nome_file, const std::string& path = "");
PGresult* execute(PGconn* conn, const char* query);
void printSeparator(int campi, int* maxChar);
void printQuery(PGresult* res);
std::string queryReader(const std::string& path, const std::string& nome_file);

int main()
{
    const std::string NOME_DB = "dbname=cineplace+"; 
    const std::string USER = "user=postgres";
    const std::string PASSWORD = "password=basi2022";
    const std::string blank = " ";                                                                          //i vari parimetri per la connessione devono essere separati da un black space

    std::string s = NOME_DB + blank + USER + blank + PASSWORD;
    const char* connInfo = s.c_str();                                                                       // string ---> char* 
    
    /*
    PGconn* conn = PQconnectdb(t);                                                                          // connessione al db

    if (PQstatus(conn) == CONNECTION_BAD){                                                                  // controllo che tutto sia andato bene
        std::cerr <<"Connection to database failed:" << PQerrorMessage(conn);
        abort(conn);
    }*/

    menu(connInfo);
}

void abort(PGconn* conn , PGresult* res ){

    if (res != nullptr)
        PQclear(res);

    if (conn != nullptr)
        PQfinish(conn);

    exit(1);
}


void menu(const char* connInfo)
{
    std::cout<<"/t MENU /n";
    std::cout<<" 1 - reset tabelle 1 /n";
    std::cout<<" 2 - insert dati nelle tabelle 1 /n";

    int scelta;
    std::cin>>scelta;

    //TODO:da fare tutte le funzioni per l'esecuzione delle query
    switch(scelta){
        case 1:
            {
                PGconn* conn = connect(connInfo);
                std::string s = queryReader("", "create_tables");                           //copia la query da file
                const char* query = s.c_str();
                PGresult* res = execute(conn,query);                                        //esegue query
                abort(conn , res);
            }
            break; 
        case 2:
            {
                PGconn* conn = connect(connInfo);
                std::string s = queryReader("", "insert_tuples");
                const char* query = s.c_str();
                PGresult* res = execute(conn,query);
                abort(conn , res);
            }
            break;
    }
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
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        std::cout << " Risultati inconsistenti!" << PQerrorMessage(conn) << std::endl;
        PQclear(res);
        exit(1);
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