-- (1) Utilizando uma query, obtenha todos os usuários (users) que vivem na cidade 
-- (cities) cujo nome seja “Rio de Janeiro”.

SELECT u.id, u.name, c.name AS city FROM users u 
JOIN cities c ON u."cityId" = c.id 
WHERE c.name = 'Rio de Janeiro'
ORDER BY u.id;

-- (2) Utilizando umas query, obtenha todos os depoimentos (testimonials) cadastrados, 
-- incluindo o nome do remetente e do destinatário.

SELECT t.id, u1.name AS writer, u2.name AS recipient, message 
FROM testimonials t
JOIN users u1 ON t."writerId" = u1.id
JOIN users u2 ON t."recipientId" = u2.id
ORDER BY t.id;

-- (3) Utilizando uma query, obtenha todos os cursos (courses) que o usuário com id 30 
-- já finalizou, incluindo o nome da escola. O que indica que um usuário terminou um curso é o campo status da tabela educations, que deve estar como "finished".

SELECT e."userId" AS id, u.name, c.name AS course, s.name AS school, "endDate"  FROM educations e
JOIN users u ON e."userId" = u.id
JOIN courses c ON e."courseId" = c.id
JOIN schools s ON e."schoolId" = s.id
WHERE "userId" = 30 AND status = 'finished'
ORDER BY id;

-- (4) Utilizando uma query, obtenha as empresas (companies) para as quais o usuário 
-- com id 50 trabalha atualmente. Para filtrar quem trabalha atualmente, utilize o 
-- campo endDate da tabela experiences. Se ele estiver null (IS NULL), significa que 
-- a pessoa ainda não encerrou a experiência dela na empresa, ou seja, está 
-- trabalhando lá.

SELECT "userId" as id, u.name, r.name AS role, c.name AS company, "startDate" FROM experiences e
JOIN users u ON e."userId" = u.id
JOIN roles r ON e."roleId" = r.id
JOIN companies c ON e."companyId" = c.id
WHERE "userId" = 50 AND "endDate" IS NULL
ORDER BY id;

-- (BÔNUS) Utilizando uma query, obtenha a lista das diferentes escolas (schools) e 
-- cursos (courses) onde estudaram as pessoas que estão aplicando pra posição de 
-- “Software Engineer” na empresa com id 10. Só devem ser consideradas as vagas que 
-- estiverem ativas, ou seja, quando o campo active da tabela jobs estiver true.

SELECT s.id, s.name AS school, cou.name AS course, com.name AS company, r.name AS role FROM applicants a
JOIN jobs j ON a."jobId" = j.id
JOIN companies com ON j."companyId" = com.id
JOIN roles r ON j."roleId" = r.id
JOIN educations e ON a."userId" = e."userId"
JOIN courses cou ON e."courseId" = cou.id
JOIN schools s ON e."schoolId" = s.id
WHERE r.name = 'Software Engineer' AND active = true;