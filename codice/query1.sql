SELECT p.nome AS nome, p.cognome, p.cf, a.premium AS puo_recensire, count(*) AS biglietti_acquistati
    FROM persona AS p JOIN account AS a ON p.cf = a.cf JOIN biglietto AS b ON a.email = b.email
    GROUP BY p.nome, p.cognome, p.cf, a.premium