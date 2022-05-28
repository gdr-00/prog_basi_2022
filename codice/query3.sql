select p.nome, p.cognome, p.cf
    from persona as p, account as a
    where a.email in (select email
					from biglietto
					group by posto, email
					having count(biglietto_id)>1) and p.cf = a.cf
    group by p.cf