SELECT c.nome, c.citta, SUM(prezzo) AS incassi_totali
	FROM cinema AS c JOIN sala AS s on c.nome = s.nome_cinema AND c.citta = s.citta_cinema 
	JOIN biglietto AS b ON s.numero_sala = b.numero_sala AND s.nome_cinema = b.nome_cinema AND s.citta_cinema = b.citta_cinema
	GROUP BY c.nome, c.citta
	HAVING SUM(prezzo) > money(100)
	ORDER BY incassi_totali