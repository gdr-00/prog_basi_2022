SELECT c.nome, c.citta,s.numero_sala
    FROM cinema c, sala s, programmazione p, film f
    WHERE s.nome_cinema = c.nome AND s.citta_cinema = c.citta
        AND s.nome_cinema = p.nome_cinema AND s.citta_cinema = p.citta_cinema AND p.numero_sala = s.numero_sala
        AND f.nome_film = p.nome_film AND f.anno_uscita=p.anno_uscita
        AND f.nome_film = 'Avengers: Endgame';