SELECT p.nome, p.cognome, p.cf
    FROM persona AS p, account AS a
    WHERE a.email in (SELECT email
					FROM biglietto
					GROUP BY posto, email
					HAVING count(biglietto_id)>1) AND p.cf = a.cf
    GROUP BY p.cf