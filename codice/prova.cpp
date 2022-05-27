#include <iostream>
#include <fstream>
#include <string>
#include <cstring>
#include <vector>

void queryReader(const std::string& path, const std::string& nome_file, std::vector<const char*>& query){
    std::ifstream file(path+nome_file+".sql");
    if(!file.good()) {
        std::cout << "errore\n";
        return;
    }
    std::string s;
    while(std::getline(file, s, ';')){
        s.append(1, ';');
        query.push_back(s.c_str());
    }
}

int main(int argc, char const *argv[])
{
    std::vector<const char*> query;
    queryReader("", "create_tables", query);
    std::cout << query.size();
    for(std::vector<const char*>::const_iterator it=query.begin(); it!=query.end() ;++it){
        std::cout << *it;
    }
    return 0;
}