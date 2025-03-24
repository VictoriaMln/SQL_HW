-- База данных 3. Бронирование отелей

-- Скрипт создания таблиц базы MySQL

-- Создание таблицы Hotel
CREATE TABLE Hotel (
    ID_hotel INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);
-- Создание таблицы Room
CREATE TABLE Room (
    ID_room INT PRIMARY KEY,
    ID_hotel INT,
    room_type ENUM('Single', 'Double', 'Suite') NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    capacity INT NOT NULL,
    FOREIGN KEY (ID_hotel) REFERENCES Hotel(ID_hotel)
);
-- Создание таблицы Customer
CREATE TABLE Customer (
    ID_customer INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL
);
-- Создание таблицы Booking
CREATE TABLE Booking (
    ID_booking INT PRIMARY KEY,
    ID_room INT,
    ID_customer INT,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    FOREIGN KEY (ID_room) REFERENCES Room(ID_room),
    FOREIGN KEY (ID_customer) REFERENCES Customer(ID_customer)
);

-- Скрипт наполнения базы данными

-- Вставка данных в таблицу Hotel
INSERT INTO Hotel (ID_hotel, name, location) VALUES
(1, 'Grand Hotel', 'Paris, France'),
(2, 'Ocean View Resort', 'Miami, USA'),
(3, 'Mountain Retreat', 'Aspen, USA'),
(4, 'City Center Inn', 'New York, USA'),
(5, 'Desert Oasis', 'Las Vegas, USA'),
(6, 'Lakeside Lodge', 'Lake Tahoe, USA'),
(7, 'Historic Castle', 'Edinburgh, Scotland'),
(8, 'Tropical Paradise', 'Bali, Indonesia'),
(9, 'Business Suites', 'Tokyo, Japan'),
(10, 'Eco-Friendly Hotel', 'Copenhagen, Denmark');
-- Вставка данных в таблицу Room
INSERT INTO Room (ID_room, ID_hotel, room_type, price, capacity) VALUES
(1, 1, 'Single', 150.00, 1),
(2, 1, 'Double', 200.00, 2),
(3, 1, 'Suite', 350.00, 4),
(4, 2, 'Single', 120.00, 1),
(5, 2, 'Double', 180.00, 2),
(6, 2, 'Suite', 300.00, 4),
(7, 3, 'Double', 250.00, 2),
(8, 3, 'Suite', 400.00, 4),
(9, 4, 'Single', 100.00, 1),
(10, 4, 'Double', 150.00, 2),
(11, 5, 'Single', 90.00, 1),
(12, 5, 'Double', 140.00, 2),
(13, 6, 'Suite', 280.00, 4),
(14, 7, 'Double', 220.00, 2),
(15, 8, 'Single', 130.00, 1),
(16, 8, 'Double', 190.00, 2),
(17, 9, 'Suite', 360.00, 4),
(18, 10, 'Single', 110.00, 1),
(19, 10, 'Double', 160.00, 2);
-- Вставка данных в таблицу Customer
INSERT INTO Customer (ID_customer, name, email, phone) VALUES
(1, 'John Doe', 'john.doe@example.com', '+1234567890'),
(2, 'Jane Smith', 'jane.smith@example.com', '+0987654321'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '+1122334455'),
(4, 'Bob Brown', 'bob.brown@example.com', '+2233445566'),
(5, 'Charlie White', 'charlie.white@example.com', '+3344556677'),
(6, 'Diana Prince', 'diana.prince@example.com', '+4455667788'),
(7, 'Ethan Hunt', 'ethan.hunt@example.com', '+5566778899'),
(8, 'Fiona Apple', 'fiona.apple@example.com', '+6677889900'),
(9, 'George Washington', 'george.washington@example.com', '+7788990011'),
(10, 'Hannah Montana', 'hannah.montana@example.com', '+8899001122');
-- Вставка данных в таблицу Booking с разнообразием клиентов
INSERT INTO Booking (ID_booking, ID_room, ID_customer, check_in_date, check_out_date) VALUES
(1, 1, 1, '2025-05-01', '2025-05-05'),  -- 4 ночи, John Doe
(2, 2, 2, '2025-05-02', '2025-05-06'),  -- 4 ночи, Jane Smith
(3, 3, 3, '2025-05-03', '2025-05-07'),  -- 4 ночи, Alice Johnson
(4, 4, 4, '2025-05-04', '2025-05-08'),  -- 4 ночи, Bob Brown
(5, 5, 5, '2025-05-05', '2025-05-09'),  -- 4 ночи, Charlie White
(6, 6, 6, '2025-05-06', '2025-05-10'),  -- 4 ночи, Diana Prince
(7, 7, 7, '2025-05-07', '2025-05-11'),  -- 4 ночи, Ethan Hunt
(8, 8, 8, '2025-05-08', '2025-05-12'),  -- 4 ночи, Fiona Apple
(9, 9, 9, '2025-05-09', '2025-05-13'),  -- 4 ночи, George Washington
(10, 10, 10, '2025-05-10', '2025-05-14'),  -- 4 ночи, Hannah Montana
(11, 1, 2, '2025-05-11', '2025-05-15'),  -- 4 ночи, Jane Smith
(12, 2, 3, '2025-05-12', '2025-05-14'),  -- 2 ночи, Alice Johnson
(13, 3, 4, '2025-05-13', '2025-05-15'),  -- 2 ночи, Bob Brown
(14, 4, 5, '2025-05-14', '2025-05-16'),  -- 2 ночи, Charlie White
(15, 5, 6, '2025-05-15', '2025-05-16'),  -- 1 ночь, Diana Prince
(16, 6, 7, '2025-05-16', '2025-05-18'),  -- 2 ночи, Ethan Hunt
(17, 7, 8, '2025-05-17', '2025-05-21'),  -- 4 ночи, Fiona Apple
(18, 8, 9, '2025-05-18', '2025-05-19'),  -- 1 ночь, George Washington
(19, 9, 10, '2025-05-19', '2025-05-22'),  -- 3 ночи, Hannah Montana
(20, 10, 1, '2025-05-20', '2025-05-22'), -- 2 ночи, John Doe
(21, 1, 2, '2025-05-21', '2025-05-23'),  -- 2 ночи, Jane Smith
(22, 2, 3, '2025-05-22', '2025-05-25'),  -- 3 ночи, Alice Johnson
(23, 3, 4, '2025-05-23', '2025-05-26'),  -- 3 ночи, Bob Brown
(24, 4, 5, '2025-05-24', '2025-05-25'),  -- 1 ночь, Charlie White
(25, 5, 6, '2025-05-25', '2025-05-27'),  -- 2 ночи, Diana Prince
(26, 6, 7, '2025-05-26', '2025-05-29');  -- 3 ночи, Ethan Hunt

/*Задача 1
Условие: определить, какие клиенты сделали более двух бронирований в разных отелях, и вывести информацию о каждом таком клиенте, включая его имя, электронную почту, 
телефон, общее количество бронирований, а также список отелей, в которых они бронировали номера (объединенные в одно поле через запятую с помощью CONCAT). 
Также подсчитать среднюю длительность их пребывания (в днях) по всем бронированиям. Отсортировать результаты по количеству бронирований в порядке убывания.
Решение: */
SELECT 
    customer.name AS customer_name,
    customer.email,
    customer.phone,
    COUNT(booking.ID_booking) AS total_bookings,
    GROUP_CONCAT(DISTINCT hotel.name ORDER BY hotel.name SEPARATOR ', ') AS hotels,
    AVG(DATEDIFF(booking.check_out_date, booking.check_in_date)) AS average_stay_days
FROM booking
JOIN customer ON booking.ID_customer = customer.ID_customer
JOIN room ON booking.ID_room = room.ID_room
JOIN hotel ON room.ID_hotel = hotel.ID_hotel
GROUP BY customer.ID_customer, customer.name, customer.email, customer.phone
HAVING COUNT(booking.ID_booking) > 2
   && COUNT(DISTINCT hotel.ID_hotel) > 1
ORDER BY total_bookings DESC;

/*Задача 2
Условие: необходимо провести анализ клиентов, которые сделали более двух бронирований в разных отелях и потратили более 500 долларов на свои бронирования.
Для этого: 
          - Определить клиентов, которые сделали более двух бронирований и забронировали номера в более чем одном отеле. 
          - Вывести для каждого такого клиента следующие данные: ID_customer, имя, общее количество бронирований, общее количество уникальных отелей, в которых они бронировали номера,
            и общую сумму, потраченную на бронирования.
          - Также определить клиентов, которые потратили более 500 долларов на бронирования, и вывести для них ID_customer, имя, общую сумму, потраченную на бронирования, 
            и общее количество бронирований.
          - В результате объединить данные из первых двух пунктов, чтобы получить список клиентов, которые соответствуют условиям обоих запросов. Отобразить поля: 
            ID_customer, имя, общее количество бронирований, общую сумму, потраченную на бронирования, и общее количество уникальных отелей.
          - Результаты отсортировать по общей сумме, потраченной клиентами, в порядке возрастания. 
Решение: */
SELECT 
    customer.ID_customer,
    customer.name,
    COUNT(booking.ID_booking) AS total_bookings,
    SUM(room.price) AS total_spent,
    COUNT(DISTINCT room.ID_hotel) AS unique_hotels
FROM booking
JOIN customer ON booking.ID_customer = customer.ID_customer
JOIN room ON booking.ID_room = room.ID_room
GROUP BY customer.ID_customer, customer.name
HAVING COUNT(booking.ID_booking) > 2
   && COUNT(DISTINCT room.ID_hotel) > 1
   && SUM(DATEDIFF(booking.check_out_date, booking.check_in_date) * room.price) > 500
ORDER BY total_spent ASC;

/* Задача 3
Условие: вам необходимо провести анализ данных о бронированиях в отелях и определить предпочтения клиентов по типу отелей. Для этого выполните следующие шаги:

- Категоризация отелей.
Определите категорию каждого отеля на основе средней стоимости номера:
  «Дешевый»: средняя стоимость менее 175 долларов.
  «Средний»: средняя стоимость от 175 до 300 долларов.
  «Дорогой»: средняя стоимость более 300 долларов.

- Анализ предпочтений клиентов.
Для каждого клиента определите предпочитаемый тип отеля на основании условия ниже:
  Если у клиента есть хотя бы один «дорогой» отель, присвойте ему категорию «дорогой».
  Если у клиента нет «дорогих» отелей, но есть хотя бы один «средний», присвойте ему категорию «средний».
  Если у клиента нет «дорогих» и «средних» отелей, но есть «дешевые», присвойте ему категорию предпочитаемых отелей «дешевый».

- Вывод информации.
Выведите для каждого клиента следующую информацию:
  ID_customer: уникальный идентификатор клиента.
  name: имя клиента.
  preferred_hotel_type: предпочитаемый тип отеля.
  visited_hotels: список уникальных отелей, которые посетил клиент.

- Сортировка результатов.
Отсортируйте клиентов так, чтобы сначала шли клиенты с «дешевыми» отелями, затем со «средними» и в конце — с «дорогими».
Решение: */
WITH hotel_categories AS (
  SELECT 
    h.ID_hotel,
    h.name AS hotel_name,
    AVG(r.price) AS avg_price,
    CASE
      WHEN AVG(r.price) < 175 THEN 'Дешевый'
      WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
      ELSE 'Дорогой'
    END AS hotel_category
  FROM hotel h
  JOIN room r ON h.ID_hotel = r.ID_hotel
  GROUP BY h.ID_hotel, h.name
),
customer_bookings AS (
  SELECT 
    b.ID_customer,
    hc.hotel_name,
    hc.hotel_category
  FROM booking b
  JOIN room r ON b.ID_room = r.ID_room
  JOIN hotel_categories hc ON r.ID_hotel = hc.ID_hotel
),
customer_preferences AS (
  SELECT 
    cb.ID_customer,
    GROUP_CONCAT(DISTINCT cb.hotel_name ORDER BY cb.hotel_name SEPARATOR ', ') AS visited_hotels,
    CASE 
      WHEN SUM(CASE WHEN cb.hotel_category = 'Дорогой' THEN 1 ELSE 0 END) > 0 THEN 'Дорогой'
      WHEN SUM(CASE WHEN cb.hotel_category = 'Средний' THEN 1 ELSE 0 END) > 0 THEN 'Средний'
      WHEN SUM(CASE WHEN cb.hotel_category = 'Дешевый' THEN 1 ELSE 0 END) > 0 THEN 'Дешевый'
    END AS preferred_hotel_type
  FROM customer_bookings cb
  GROUP BY cb.ID_customer
)
SELECT 
  c.ID_customer,
  c.name,
  cp.preferred_hotel_type,
  cp.visited_hotels
FROM Customer c
JOIN customer_preferences cp ON c.ID_customer = cp.ID_customer
ORDER BY FIELD(cp.preferred_hotel_type, 'Дешевый', 'Средний', 'Дорогой');
