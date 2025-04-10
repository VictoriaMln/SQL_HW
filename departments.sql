-- База данных 4. Структура организации
-- Скрипт создания таблиц базы MySQL
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    ManagerID INT,
    DepartmentID INT,
    RoleID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    TaskName VARCHAR(100) NOT NULL,
    AssignedTo INT,
    ProjectID INT,
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Скрипт наполнения базы данными
-- Добавление отделов
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Отдел продаж'),
(2, 'Отдел маркетинга'),
(3, 'IT-отдел'),
(4, 'Отдел разработки'),
(5, 'Отдел поддержки');
-- Добавление ролей
INSERT INTO Roles (RoleID, RoleName) VALUES
(1, 'Менеджер'),
(2, 'Директор'),
(3, 'Генеральный директор'),
(4, 'Разработчик'),
(5, 'Специалист по поддержке'),
(6, 'Маркетолог');
-- Добавление сотрудников
INSERT INTO Employees (EmployeeID, Name, Position, ManagerID, DepartmentID, RoleID) VALUES
(1, 'Иван Иванов', 'Генеральный директор', NULL, 1, 3),
(2, 'Петр Петров', 'Директор по продажам', 1, 1, 2),
(3, 'Светлана Светлова', 'Директор по маркетингу', 1, 2, 2),
(4, 'Алексей Алексеев', 'Менеджер по продажам', 2, 1, 1),
(5, 'Мария Мариева', 'Менеджер по маркетингу', 3, 2, 1),
(6, 'Андрей Андреев', 'Разработчик', 1, 4, 4),
(7, 'Елена Еленова', 'Специалист по поддержке', 1, 5, 5),
(8, 'Олег Олегов', 'Менеджер по продукту', 2, 1, 1),
(9, 'Татьяна Татеева', 'Маркетолог', 3, 2, 6),
(10, 'Николай Николаев', 'Разработчик', 6, 4, 4),
(11, 'Ирина Иринина', 'Разработчик', 6, 4, 4),
(12, 'Сергей Сергеев', 'Специалист по поддержке', 7, 5, 5),
(13, 'Кристина Кристинина', 'Менеджер по продажам', 4, 1, 1),
(14, 'Дмитрий Дмитриев', 'Маркетолог', 3, 2, 6),
(15, 'Виктор Викторов', 'Менеджер по продажам', 4, 1, 1),
(16, 'Анастасия Анастасиева', 'Специалист по поддержке', 7, 5, 5),
(17, 'Максим Максимов', 'Разработчик', 6, 4, 4),
(18, 'Людмила Людмилова', 'Специалист по маркетингу', 3, 2, 6),
(19, 'Наталья Натальева', 'Менеджер по продажам', 4, 1, 1),
(20, 'Александр Александров', 'Менеджер по маркетингу', 3, 2, 1),
(21, 'Галина Галина', 'Специалист по поддержке', 7, 5, 5),
(22, 'Павел Павлов', 'Разработчик', 6, 4, 4),
(23, 'Марина Маринина', 'Специалист по маркетингу', 3, 2, 6),
(24, 'Станислав Станиславов', 'Менеджер по продажам', 4, 1, 1),
(25, 'Екатерина Екатеринина', 'Специалист по поддержке', 7, 5, 5),
(26, 'Денис Денисов', 'Разработчик', 6, 4, 4),
(27, 'Ольга Ольгина', 'Маркетолог', 3, 2, 6),
(28, 'Игорь Игорев', 'Менеджер по продукту', 2, 1, 1),
(29, 'Анастасия Анастасиевна', 'Специалист по поддержке', 7, 5, 5),
(30, 'Валентин Валентинов', 'Разработчик', 6, 4, 4);
-- Добавление проектов
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) VALUES
(1, 'Проект A', '2025-01-01', '2025-12-31', 1),
(2, 'Проект B', '2025-02-01', '2025-11-30', 2),
(3, 'Проект C', '2025-03-01', '2025-10-31', 4),
(4, 'Проект D', '2025-04-01', '2025-09-30', 5),
(5, 'Проект E', '2025-05-01', '2025-08-31', 3);
-- Добавление задач
INSERT INTO Tasks (TaskID, TaskName, AssignedTo, ProjectID) VALUES
(1, 'Задача 1: Подготовка отчета по продажам', 4, 1),
(2, 'Задача 2: Анализ рынка', 9, 2),
(3, 'Задача 3: Разработка нового функционала', 10, 3),
(4, 'Задача 4: Поддержка клиентов', 12, 4),
(5, 'Задача 5: Создание рекламной кампании', 5, 2),
(6, 'Задача 6: Обновление документации', 6, 3),
(7, 'Задача 7: Проведение тренинга для сотрудников', 8, 1),
(8, 'Задача 8: Тестирование нового продукта', 11, 3),
(9, 'Задача 9: Ответы на запросы клиентов', 12, 4),
(10, 'Задача 10: Подготовка маркетинговых материалов', 9, 2),
(11, 'Задача 11: Интеграция с новым API', 10, 3),
(12, 'Задача 12: Настройка системы поддержки', 7, 5),
(13, 'Задача 13: Проведение анализа конкурентов', 9, 2),
(14, 'Задача 14: Создание презентации для клиентов', 4, 1),
(15, 'Задача 15: Обновление сайта', 6, 3);

/*Задача 1
Условие: найти всех сотрудников, подчиняющихся Ивану Иванову (с EmployeeID = 1), включая их подчиненных и подчиненных подчиненных.
Для каждого сотрудника вывести следующую информацию:
  - EmployeeID: идентификатор сотрудника.
  - Имя сотрудника.
  - ManagerID: Идентификатор менеджера.
  - Название отдела, к которому он принадлежит.
  - Название роли, которую он занимает.
  - Название проектов, к которым он относится (если есть, конкатенированные в одном столбце через запятую).
  - Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце через запятую).
  - Если у сотрудника нет назначенных проектов или задач, отобразить NULL.
Требования:
  - Рекурсивно извлечь всех подчиненных сотрудников Ивана Иванова и их подчиненных.
  - Для каждого сотрудника отобразить информацию из всех таблиц.
  - Результаты должны быть отсортированы по имени сотрудника.
  - Решение задачи должно представлять из себя один sql-запрос и задействовать ключевое слово RECURSIVE.
Решение: */
WITH RECURSIVE employee_tree AS (
  SELECT 
    employeeID,
    name,
    managerID,
    departmentID,
    roleID
  FROM employees
  WHERE employeeID = 1
  
  UNION ALL
  
  SELECT 
    employees.employeeID,
    employees.name,
    employees.managerID,
    employees.departmentID,
    employees.roleID
  FROM employees
  JOIN employee_tree ON employees.managerID = employee_tree.employeeID
),
empl_tasks AS (
  SELECT 
    assignedTo,
    GROUP_CONCAT(taskName ORDER BY taskID DESC SEPARATOR ', ') AS TaskNames
  FROM tasks
  GROUP BY assignedTo
)
SELECT 
  employee_tree.employeeID,
  employee_tree.name AS EmployeeName,
  employee_tree.managerID,
  departments.departmentName,
  roles.roleName,
  projects.projectName AS ProjectNames,
  empl_tasks.taskNames
FROM employee_tree
JOIN departments ON employee_tree.departmentID = departments.departmentID
JOIN roles ON employee_tree.roleID = roles.roleID
LEFT JOIN projects ON employee_tree.departmentID = projects.departmentID
LEFT JOIN empl_tasks ON employee_tree.employeeID = empl_tasks.assignedTo
ORDER BY employee_tree.name;

/*Задача 2
Условие: найти всех сотрудников, подчиняющихся Ивану Иванову с EmployeeID = 1, включая их подчиненных и подчиненных подчиненных.
Для каждого сотрудника вывести следующую информацию:
  - EmployeeID: идентификатор сотрудника.
  - Имя сотрудника.
  - Идентификатор менеджера.
  - Название отдела, к которому он принадлежит.
  - Название роли, которую он занимает.
  - Название проектов, к которым он относится (если есть, конкатенированные в одном столбце).
  - Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце).
  - Общее количество задач, назначенных этому сотруднику.
  - Общее количество подчиненных у каждого сотрудника (не включая подчиненных их подчиненных).
  - Если у сотрудника нет назначенных проектов или задач, отобразить NULL.
  - Решение задачи должно представлять из себя один sql-запрос и задействовать ключевое слово RECURSIVE.
Решение: */
WITH RECURSIVE hierarchy AS (
  SELECT 
    employees.employeeID,
    employees.name,
    employees.managerID,
    employees.departmentID,
    employees.roleID
  FROM employees
  WHERE employees.employeeID = 1
  
  UNION ALL
  
  SELECT 
    employees.employeeID,
    employees.name,
    employees.managerID,
    employees.departmentID,
    employees.roleID
  FROM employees
  JOIN hierarchy ON employees.managerID = hierarchy.employeeID
)
SELECT 
  hierarchy.employeeID,
  hierarchy.name AS EmployeeName,
  hierarchy.managerID,
  departments.departmentName,
  roles.roleName,
  (SELECT GROUP_CONCAT(projects.projectName ORDER BY projects.projectName SEPARATOR ', ')
   FROM projects
   WHERE projects.departmentID = hierarchy.departmentID) AS ProjectNames,
  (SELECT GROUP_CONCAT(tasks.taskName ORDER BY tasks.taskName SEPARATOR ', ')
   FROM tasks
   WHERE tasks.assignedTo = hierarchy.employeeID) AS TaskNames,
  (SELECT COUNT(*)
   FROM tasks
   WHERE tasks.assignedTo = hierarchy.employeeID) AS TotalTasks,
  (SELECT COUNT(*)
   FROM employees
   WHERE employees.managerID = hierarchy.employeeID) AS TotalSubordinates
FROM hierarchy
JOIN departments ON hierarchy.departmentID = departments.departmentID
JOIN roles ON hierarchy.roleID = roles.roleID
ORDER BY hierarchy.name;

/*Задача 3
Условие: найти всех сотрудников, которые занимают роль менеджера и имеют подчиненных (то есть число подчиненных больше 0). 
Для каждого такого сотрудника вывести следующую информацию:
  - EmployeeID: идентификатор сотрудника.
  - Имя сотрудника.
  - Идентификатор менеджера.
  - Название отдела, к которому он принадлежит.
  - Название роли, которую он занимает.
  - Название проектов, к которым он относится (если есть, конкатенированные в одном столбце).
  - Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце).
  - Общее количество подчиненных у каждого сотрудника (включая их подчиненных).
  - Если у сотрудника нет назначенных проектов или задач, отобразить NULL.
  - Решение задачи должно представлять из себя один sql-запрос и задействовать ключевое слово RECURSIVE.
Решение:*/
WITH RECURSIVE managerSubordinates AS (
  SELECT 
    employees.employeeID AS ManagerEmployeeID,
    subordinate.employeeID AS SubordinateEmployeeID
  FROM employees
  JOIN employees AS subordinate 
    ON subordinate.managerID = employees.employeeID
  WHERE employees.roleID = (SELECT roleID FROM roles WHERE roleName = 'Менеджер')
  
  UNION ALL
  
  SELECT 
    managerSubordinates.managerEmployeeID,
    employees.employeeID AS SubordinateEmployeeID
  FROM managerSubordinates
  JOIN employees 
    ON employees.managerID = managerSubordinates.subordinateEmployeeID
),
aggregatedSubordinateCount AS (
  SELECT 
    managerEmployeeID, 
    COUNT(DISTINCT subordinateEmployeeID) AS TotalSubordinates
  FROM managerSubordinates
  GROUP BY managerEmployeeID
)
SELECT 
  managerData.employeeID,
  managerData.name AS EmployeeName,
  managerData.managerID,
  departments.departmentName,
  roles.roleName,
  (
    SELECT GROUP_CONCAT(projects.projectName ORDER BY projects.projectName SEPARATOR ', ')
    FROM projects
    WHERE projects.departmentID = managerData.departmentID
  ) AS ProjectNames,
  (
    SELECT GROUP_CONCAT(tasks.taskName ORDER BY tasks.taskName SEPARATOR ', ')
    FROM tasks
    WHERE tasks.assignedTo = managerData.employeeID
  ) AS TaskNames,
  aggregatedSubordinateCount.totalSubordinates
FROM employees AS ManagerData
JOIN roles ON managerData.roleID = roles.roleID
JOIN departments ON managerData.departmentID = departments.departmentID
JOIN aggregatedSubordinateCount ON managerData.employeeID = aggregatedSubordinateCount.managerEmployeeID
WHERE roles.roleName = 'Менеджер'
  && aggregatedSubordinateCount.totalSubordinates > 0
ORDER BY managerData.name;
