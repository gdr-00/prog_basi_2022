SELECT p.nome, p.cognome, a.email
    FROM persona AS p, account AS a
    WHERE a.email in (SELECT email
					FROM biglietto
					GROUP BY posto, email
					HAVING count(biglietto_id)>1) AND p.cf = a.cf
    GROUP BY p.cf, a.email