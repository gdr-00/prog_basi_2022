SELECT p.nome,p.cognome, p.email , count(*) as Numero_biglietti_acquistati
    FROM p_a p join biglietto b on p.email=b.email
    GROUP BY p.nome, p.cognome, p.email
    ORDER BY Numero_biglietti_acquistati DESC
    LIMIT 1