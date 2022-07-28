-- (1) Utilizando uma query, obtenha a quantidade de experiências (experiences) atuais,
-- ou seja, com “endDate” diferente de NULL.

SELECT COUNT("endDate") AS "currentExperiences" 
FROM experiences;

-- (2) Utilizando uma *query*, obtenha a quantidade de graduações (`educations`) por 
-- usuário, incluindo o seu id.

SELECT "userId" AS id, COUNT("courseId") AS educations 
FROM educations 
GROUP BY "userId" ;

-- (3) Utilizando uma query, obtenha a quantidade de depoimentos(testimonials) que 
-- o usuário com id 435 efetuou, incluindo o seu nome. 

SELECT u.name AS writer, COUNT(message)
FROM testimonials t
JOIN users u ON u.id = t."writerId"
WHERE t."writerId" = 435
GROUP BY t."writerId", u.name;

-- (4) Utilizando uma query, obtenha o maior salário das vagas (jobs) ativas (active = 
-- true) e o nome das posições (roles) dessas vagas ordenadas de forma ascendente

SELECT MAX(salary) AS "maximumSalary", r.name AS role
FROM jobs j
JOIN roles r ON r.id = j."roleId"
WHERE active = true
GROUP BY r.id
ORDER BY "maximumSalary";

-- (BÔNUS) Utilizando uma query, obtenha os 3 cursos (courses) e escolas (schools) 
-- com a maior quantidade de alunos (educations) que estão cursando (status='ongoing') 
-- ou finalizaram (status='finished') 

SELECT s.name AS school, c.name AS course, COUNT("userId") AS "studentsCount", status AS role
FROM educations e
JOIN schools s ON s.id = e."schoolId"
JOIN courses c ON c.id = e."courseId"
GROUP BY s.name, c.name, status
ORDER BY "studentsCount" DESC
LIMIT 3;