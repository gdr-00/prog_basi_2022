DROP VIEW IF EXISTS p_a;
 CREATE VIEW p_a AS
	SELECT p.nome, p.cognome, p.cf, a.email
	FROM persona AS p, account AS a
	WHERE p.cf=a.cf;
	
 SELECT nome, cognome, cf
	FROM p_a, biglietto AS b
	WHERE p_a.email NOT IN (SELECT email
						 FROM recensione_film as f
						 GROUP BY email) AND p_a.email NOT IN (SELECT email
						 										FROM recensione_sala as f
						 										GROUP BY email)
GROUP BY nome, cognome, cf