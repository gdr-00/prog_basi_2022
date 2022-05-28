SELECT p.nome as nome, p.cognome, p.cf, a.premium AS puo_recensire, count(*) AS numero_biglietti_acquistati
    FROM persona as p join account AS a ON p.cf = a.cf JOIN biglietto AS b ON a.email = b.email
    GROUP BY p.nome, p.cognome, p.cf, a.premium