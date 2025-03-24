-- База данных 2 . Автомобильные гонки

-- Скрипты создания таблиц базы MySQL
-- Создание таблицы Classes
CREATE TABLE Classes (
    class VARCHAR(100) NOT NULL,
    type ENUM('Racing', 'Street') NOT NULL,
    country VARCHAR(100) NOT NULL,
    numDoors INT NOT NULL,
    engineSize DECIMAL(3, 1) NOT NULL, -- размер двигателя в литрах
    weight INT NOT NULL,                -- вес автомобиля в килограммах
    PRIMARY KEY (class)
);
-- Создание таблицы Cars
CREATE TABLE Cars (
    name VARCHAR(100) NOT NULL,
    class VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY (name),
    FOREIGN KEY (class) REFERENCES Classes(class)
);
-- Создание таблицы Races
CREATE TABLE Races (
    name VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (name)
);
-- Создание таблицы Results
CREATE TABLE Results (
    car VARCHAR(100) NOT NULL,
    race VARCHAR(100) NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (car, race),
    FOREIGN KEY (car) REFERENCES Cars(name),
    FOREIGN KEY (race) REFERENCES Races(name)
);

-- Скрипты наполнения базы данными
-- Вставка данных в таблицу Classes
INSERT INTO Classes (class, type, country, numDoors, engineSize, weight) VALUES
('SportsCar', 'Racing', 'USA', 2, 3.5, 1500),
('Sedan', 'Street', 'Germany', 4, 2.0, 1200),
('SUV', 'Street', 'Japan', 4, 2.5, 1800),
('Hatchback', 'Street', 'France', 5, 1.6, 1100),
('Convertible', 'Racing', 'Italy', 2, 3.0, 1300),
('Coupe', 'Street', 'USA', 2, 2.5, 1400),
('Luxury Sedan', 'Street', 'Germany', 4, 3.0, 1600),
('Pickup', 'Street', 'USA', 2, 2.8, 2000);
-- Вставка данных в таблицу Cars
INSERT INTO Cars (name, class, year) VALUES
('Ford Mustang', 'SportsCar', 2020),
('BMW 3 Series', 'Sedan', 2019),
('Toyota RAV4', 'SUV', 2021),
('Renault Clio', 'Hatchback', 2020),
('Ferrari 488', 'Convertible', 2019),
('Chevrolet Camaro', 'Coupe', 2021),
('Mercedes-Benz S-Class', 'Luxury Sedan', 2022),
('Ford F-150', 'Pickup', 2021),
('Audi A4', 'Sedan', 2018),
('Nissan Rogue', 'SUV', 2020);
-- Вставка данных в таблицу Races
INSERT INTO Races (name, date) VALUES
('Indy 500', '2023-05-28'),
('Le Mans', '2023-06-10'),
('Monaco Grand Prix', '2023-05-28'),
('Daytona 500', '2023-02-19'),
('Spa 24 Hours', '2023-07-29'),
('Bathurst 1000', '2023-10-08'),
('Nürburgring 24 Hours', '2023-06-17'),
('Pikes Peak International Hill Climb', '2023-06-25');
-- Вставка данных в таблицу Results
INSERT INTO Results (car, race, position) VALUES
('Ford Mustang', 'Indy 500', 1),
('BMW 3 Series', 'Le Mans', 3),
('Toyota RAV4', 'Monaco Grand Prix', 2),
('Renault Clio', 'Daytona 500', 5),
('Ferrari 488', 'Le Mans', 1),
('Chevrolet Camaro', 'Monaco Grand Prix', 4),
('Mercedes-Benz S-Class', 'Spa 24 Hours', 2),
('Ford F-150', 'Bathurst 1000', 6),
('Audi A4', 'Nürburgring 24 Hours', 8),
('Nissan Rogue', 'Pikes Peak International Hill Climb', 3);

/*Задача 1
Условие: определить, какие автомобили из каждого класса имеют наименьшую среднюю позицию в гонках, и вывести информацию о каждом таком автомобиле для данного класса,
включая его класс, среднюю позицию и количество гонок, в которых он участвовал. Также отсортировать результаты по средней позиции.
Решение: */
WITH car_average AS (
    SELECT 
        cars.name AS car_name,
        cars.class AS car_class,
        AVG(results.position) AS average_position,
        COUNT(results.race) AS race_count
    FROM cars
    JOIN results ON cars.name = results.car
    GROUP BY cars.class, cars.name
),
min_average AS (
	SELECT 
    	car_class,
    	MIN(average_position) AS min_average_position
    FROM car_average
    GROUP BY car_class
)
SELECT 
    car_average.car_name,
    car_average.car_class,
    car_average.average_position,
    car_average.race_count
FROM car_average
JOIN min_average ON car_average.car_class = min_average.car_class 
     && car_average.average_position = min_average.min_average_position
ORDER BY car_average.average_position;

/*Задача 2
Условие: определить автомобиль, который имеет наименьшую среднюю позицию в гонках среди всех автомобилей, и вывести информацию об этом автомобиле, включая его класс, 
среднюю позицию, количество гонок, в которых он участвовал, и страну производства класса автомобиля. Если несколько автомобилей имеют одинаковую наименьшую среднюю позицию,
выбрать один из них по алфавиту (по имени автомобиля).
Решение: */
WITH car_stat AS (
    SELECT 
        cars.name AS car_name,
        cars.class AS car_class,
        AVG(results.position) AS average_position,
        COUNT(results.race) AS race_count
    FROM cars
    JOIN results ON cars.name = results.car
    GROUP BY cars.name, cars.class
)
SELECT
    car_stat.car_name,
    car_stat.car_class,
    car_stat.average_position,
    car_stat.race_count,
    classes.country
FROM car_stat
JOIN classes ON car_stat.car_class = classes.class
WHERE car_stat.average_position = (SELECT MIN(average_position) FROM car_stat)
ORDER BY car_stat.car_name
LIMIT 1;

/*Задача 3
Условие: определить классы автомобилей, которые имеют наименьшую среднюю позицию в гонках, и вывести информацию о каждом автомобиле из этих классов, включая его имя, 
среднюю позицию, количество гонок, в которых он участвовал, страну производства класса автомобиля, а также общее количество гонок, в которых участвовали автомобили этих классов. 
Если несколько классов имеют одинаковую среднюю позицию, выбрать все из них.
Решение: */
WITH car_stat AS (
  SELECT 
    cars.name AS car_name,
    cars.class AS car_class,
    AVG(results.position) AS average_position,
    COUNT(results.race) AS race_count
  FROM cars
  JOIN results ON cars.name = results.car
  GROUP BY cars.name, cars.class
),
class_stat AS (
  SELECT 
    cars.class,
    AVG(results.position) AS class_average_position,
    COUNT(results.race) AS total_races
  FROM cars
  JOIN results ON cars.name = results.car
  GROUP BY cars.class
),
min_class_average AS (
  SELECT MIN(class_average_position) AS min_average
  FROM class_stat
)
SELECT 
  car_stat.car_name,
  car_stat.car_class,
  car_stat.average_position,
  car_stat.race_count,
  classes.country AS car_country,
  class_stat.total_races
FROM car_stat
JOIN class_stat ON car_stat.car_class = class_stat.class
JOIN classes ON car_stat.car_class = classes.class
JOIN min_class_average ON class_stat.class_average_position = min_class_average.min_average
ORDER BY car_stat.car_class, car_stat.car_name;

/*Задача 4
Условие: определить, какие автомобили имеют среднюю позицию лучше (меньше) средней позиции всех автомобилей в своем классе (то есть автомобилей в классе должно быть минимум
два, чтобы выбрать один из них). Вывести информацию об этих автомобилях, включая их имя, класс, среднюю позицию, количество гонок, в которых они участвовали,
и страну производства класса автомобиля. Также отсортировать результаты по классу и затем по средней позиции в порядке возрастания.
Решение: */
WITH car_stat AS (
  SELECT 
    cars.name AS car_name,
    cars.class AS car_class,
    AVG(results.position) AS average_position,
    COUNT(results.race) AS race_count
  FROM cars
  JOIN results ON cars.name = results.car
  GROUP BY cars.name, cars.class
),
class_stat AS (
  SELECT 
    cars.class,
    AVG(results.position) AS class_avg_position,
    COUNT(DISTINCT cars.name) AS car_count
  FROM cars
  JOIN results ON cars.name = results.car
  GROUP BY cars.class
  HAVING COUNT(DISTINCT cars.name) >= 2
)
SELECT 
  car_stat.car_name,
  car_stat.car_class,
  car_stat.average_position,
  car_stat.race_count,
  classes.country AS car_country
FROM car_stat
JOIN class_stat ON car_stat.car_class = class_stat.class
JOIN classes ON car_stat.car_class = classes.class
WHERE car_stat.average_position < class_stat.class_avg_position
ORDER BY car_stat.car_class, car_stat.average_position ASC;

/*Задача 5
Условие: определить, какие классы автомобилей имеют наибольшее количество автомобилей с низкой средней позицией (больше 3.0) и вывести информацию о каждом автомобиле из этих классов,
включая его имя, класс, среднюю позицию, количество гонок, в которых он участвовал, страну производства класса автомобиля, а также общее количество гонок для каждого класса. 
Отсортировать результаты по количеству автомобилей с низкой средней позицией.
Решение: */
WITH car_stat AS (
    SELECT 
        cars.name AS car_name,
        cars.class AS car_class,
        AVG(results.position) AS average_position,
        COUNT(results.race) AS race_count
    FROM cars
    JOIN results ON cars.name = results.car
    GROUP BY cars.name, cars.class
),
low_car_count AS (
    SELECT 
        car_class,
        COUNT(*) AS low_count
    FROM car_stat
    WHERE average_position >= 3.0
    GROUP BY car_class
),
class_races AS (
    SELECT 
        car_class,
        SUM(race_count) AS total_races
    FROM car_stat
    GROUP BY car_class
)
SELECT 
    car_stat.car_name,
    car_stat.car_class,
    car_stat.average_position,
    car_stat.race_count,
    classes.country AS car_country,
    class_races.total_races,
    low_car_count.low_count AS low_position_count
FROM car_stat
JOIN low_car_count ON car_stat.car_class = low_car_count.car_class
JOIN classes ON car_stat.car_class = classes.class
JOIN class_races ON car_stat.car_class = class_races.car_class
WHERE car_stat.average_position > 3.0
ORDER BY low_car_count.low_count DESC;
