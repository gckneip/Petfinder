-- 1) Lista todos os bichos com nome, raça e espécie 
SELECT b.idbicho, b.nome, r.nome AS raca, e.nome AS especie
FROM bichos.bichos b
JOIN domain.eraca r ON b.raca = r.idraca
JOIN domain.eespecie e ON b.especie = e.idespecie;

-- 2) Mostra todas as doações com nome do doador e do bicho 
SELECT d.iddoacao, u.nome AS doador, b.nome AS bicho, d.valor, d.data
FROM bichos.doacoes d
JOIN usuarios.usuarios u ON d.cpfusuario = u.cpf
JOIN bichos.bichos b ON d.idbicho = b.idbicho;

-- 3) Lista todos os profissionais e suas especialidades
SELECT p.cpf, u.nome AS profissional, e.nome AS especialidade
FROM usuarios.profissionais p
JOIN usuarios.usuarios u ON p.cpf = u.cpf
JOIN especialidades.profissionaisespecialidades pe ON p.cpf = pe.cpfprofissional
JOIN especialidades.especialidades e ON pe.idespecialidade = e.idespecialidade;

-- 4) Total de doações recebidas por cada bicho (agrupamento)
SELECT b.nome AS bicho, SUM(d.valor) AS total_doacoes
FROM bichos.bichos b
LEFT JOIN bichos.doacoes d ON b.idbicho = d.idbicho
GROUP BY b.nome
ORDER BY total_doacoes DESC;

-- 5) Bichos e suas afecções, com gravidade
SELECT b.nome AS bicho, a.nome AS afecao, g.nome AS gravidade
FROM bichos.afeccoesbichos ab
JOIN bichos.bichos b ON ab.idbicho = b.idbicho
JOIN bichos.afeccoes a ON ab.idafeccao = a.idafeccao
JOIN domain.egravidade g ON a.gravidade = g.idegravidade;

-- 6) Itens vendidos por cada petshop
SELECT ps.cnpj, e.nome AS petshop, i.nome AS item
FROM itens.petshopitens ps
JOIN itens.itens i ON ps.iditem = i.iditem
JOIN estabelecimentos.estabelecimentos e ON ps.petshop = e.cnpj;
