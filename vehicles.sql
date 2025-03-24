-- База данных 1. Транспортные средства

-- Скрипты создания таблиц:

-- Создание таблицы Vehicle  
  CREATE TABLE Vehicle (  
      maker VARCHAR(100) NOT NULL,  
      model VARCHAR(100) NOT NULL,  
      type ENUM('Car', 'Motorcycle', 'Bicycle') NOT NULL,  
      PRIMARY KEY (model)  
  );
  
-- Создание таблицы Car
  CREATE TABLE Car (  
      vin VARCHAR(17) NOT NULL,  
      model VARCHAR(100) NOT NULL,  
      engine_capacity DECIMAL(4, 2) NOT NULL, -- объем двигателя в литрах  
      horsepower INT NOT NULL,                 -- мощность в лошадиных силах  
      price DECIMAL(10, 2) NOT NULL,           -- цена в долларах  
      transmission ENUM('Automatic', 'Manual') NOT NULL, -- тип трансмиссии  
      PRIMARY KEY (vin),  
      FOREIGN KEY (model) REFERENCES Vehicle(model)  
  );  
  
-- Создание таблицы Motorcycle  
  CREATE TABLE Motorcycle (  
      vin VARCHAR(17) NOT NULL,  
      model VARCHAR(100) NOT NULL,  
      engine_capacity DECIMAL(4, 2) NOT NULL, -- объем двигателя в литрах  
      horsepower INT NOT NULL,                 -- мощность в лошадиных силах  
      price DECIMAL(10, 2) NOT NULL,           -- цена в долларах  
      type ENUM('Sport', 'Cruiser', 'Touring') NOT NULL, -- тип мотоцикла  
      PRIMARY KEY (vin),  
      FOREIGN KEY (model) REFERENCES Vehicle(model)  
  );
  
-- Создание таблицы Bicycle  
  CREATE TABLE Bicycle (  
      serial_number VARCHAR(20) NOT NULL,  
      model VARCHAR(100) NOT NULL,
      gear_count INT NOT NULL,                 -- количество передач
      price DECIMAL(10, 2) NOT NULL,           -- цена в долларах
      type ENUM('Mountain', 'Road', 'Hybrid') NOT NULL, -- тип велосипеда
      PRIMARY KEY (serial_number),
      FOREIGN KEY (model) REFERENCES Vehicle(model)
  );


-- Скрипты для наполнения таблиц:

-- Вставка данных в таблицу Vehicle
INSERT INTO Vehicle (maker, model, type) VALUES
('Toyota', 'Camry', 'Car'),
('Honda', 'Civic', 'Car'),
('Ford', 'Mustang', 'Car'),
('Yamaha', 'YZF-R1', 'Motorcycle'),
('Harley-Davidson', 'Sportster', 'Motorcycle'),
('Kawasaki', 'Ninja', 'Motorcycle'),
('Trek', 'Domane', 'Bicycle'),
('Giant', 'Defy', 'Bicycle'),
('Specialized', 'Stumpjumper', 'Bicycle');

-- Вставка данных в таблицу Car
INSERT INTO Car (vin, model, engine_capacity, horsepower, price, transmission) VALUES
('1HGCM82633A123456', 'Camry', 2.5, 203, 24000.00, 'Automatic'),
('2HGFG3B53GH123456', 'Civic', 2.0, 158, 22000.00, 'Manual'),
('1FA6P8CF0J1234567', 'Mustang', 5.0, 450, 55000.00, 'Automatic');

-- Вставка данных в таблицу Motorcycle
INSERT INTO Motorcycle (vin, model, engine_capacity, horsepower, price, type) VALUES
('JYARN28E9FA123456', 'YZF-R1', 1.0, 200, 17000.00, 'Sport'),
('1HD1ZK3158K123456', 'Sportster', 1.2, 70, 12000.00, 'Cruiser'),
('JKBVNAF156A123456', 'Ninja', 0.9, 150, 14000.00, 'Sport');

-- Вставка данных в таблицу Bicycle
INSERT INTO Bicycle (serial_number, model, gear_count, price, type) VALUES
('SN123456789', 'Domane', 22, 3500.00, 'Road'),
('SN987654321', 'Defy', 20, 3000.00, 'Road'),
('SN456789123', 'Stumpjumper', 30, 4000.00, 'Mountain');

/*Задача 1
Условие:
  Найдите производителей (maker) и модели всех мотоциклов, которые имеют мощность более 150 лошадиных сил, стоят менее 
  20 тысяч долларов и являются спортивными (тип Sport). Также отсортируйте результаты по мощности в порядке убывания. */

-- Решение:
SELECT 
  vehicle.maker,
  motorcycle.model
FROM 
  Motorcycle
JOIN 
  vehicle on motorcycle.model = vehicle.model
WHERE
  motorcycle.horsepower > 150 
  && motorcycle.price < 20000 
  && motorcycle.type = 'Sport'
ORDER BY 
  motorcycle.horsepower DESC;

/*Задача 2
Условие:
  Найти информацию о производителях и моделях различных типов транспортных средств (автомобили, мотоциклы и велосипеды), 
  которые соответствуют заданным критериям.

  Автомобили:
  Извлечь данные о всех автомобилях, которые имеют:
    Мощность двигателя более 150 лошадиных сил. Объем двигателя менее 3 литров. Цену менее 35 тысяч долларов.
    В выводе должны быть указаны производитель (maker), номер модели (model), мощность (horsepower), 
    объем двигателя (engine_capacity) и тип транспортного средства, который будет обозначен как Car.

  Мотоциклы:
  Извлечь данные о всех мотоциклах, которые имеют:
    Мощность двигателя более 150 лошадиных сил. Объем двигателя менее 1,5 литров. Цену менее 20 тысяч долларов.
    В выводе должны быть указаны производитель (maker), номер модели (model), мощность (horsepower), объем двигателя (engine_capacity)
    и тип транспортного средства, который будет обозначен как Motorcycle.

  Велосипеды:
  Извлечь данные обо всех велосипедах, которые имеют:
    Количество передач больше 18. Цену менее 4 тысяч долларов.
    В выводе должны быть указаны производитель (maker), номер модели (model), а также NULL для мощности и объема двигателя,
    так как эти характеристики не применимы для велосипедов. Тип транспортного средства будет обозначен как Bicycle.

  Сортировка:
    Результаты должны быть объединены в один набор данных и отсортированы по мощности в порядке убывания. Для велосипедов, 
    у которых нет значения мощности, они будут располагаться внизу списка. */

-- Решение:
(SELECT 
  vehicle.maker,
  car.model,
  car.horsepower,
  car.engine_capacity,
  vehicle.type
FROM 
  car
JOIN 
  vehicle on car.model = vehicle.model
WHERE
  car.horsepower > 150 
  && car.price < 35000 
  && car.engine_capacity < 3)
    
UNION ALL

(SELECT 
  vehicle.maker,
  motorcycle.model,
  motorcycle.horsepower,
  motorcycle.engine_capacity,
  vehicle.type
FROM 
  motorcycle
JOIN 
  vehicle on motorcycle.model = vehicle.model
WHERE
  motorcycle.horsepower > 150 
  && motorcycle.price < 20000 
  && motorcycle.engine_capacity < 1.5)
    
UNION ALL

(SELECT 
  vehicle.maker,
  bicycle.model,
  NULL AS horsepower,
  NULL AS engine_capacity,
  vehicle.type
FROM 
  bicycle
JOIN 
  vehicle on bicycle.model = vehicle.model
WHERE
  bicycle.gear_count > 18 
  && bicycle.price < 4000)
    
ORDER BY horsepower DESC;
