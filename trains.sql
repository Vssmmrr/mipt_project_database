--DROP SCHEMA trains CASCADE;

---- CREATE BLOCK

create schema trains;

create table trains.STATION
(
  station_id INTEGER PRIMARY KEY,
  station_nm VARCHAR(100) NOT NULL,
  location_city_nm VARCHAR(100)
);

create table trains.TRIP
(
    trip_id INTEGER PRIMARY KEY,
    departure_station_id INTEGER REFERENCES trains.STATION (station_id),
    arrival_station_id INTEGER REFERENCES trains.STATION (station_id),
    departure_dttm TIMESTAMP,
    arrival_dttm TIMESTAMP
);

create table trains.STATION_X_TRIP
(
    station_id INTEGER REFERENCES trains.STATION (station_id),
    trip_id INTEGER REFERENCES trains.TRIP (trip_id)
);

create table trains.TRAIN_MODEL
(
    train_model_id INTEGER PRIMARY KEY,
    train_model_nm VARCHAR(100),
    max_speed_amt INTEGER CHECK(max_speed_amt > 0 OR max_speed_amt IS NULL)
);

create table trains.TRAIN
(
    train_id INTEGER PRIMARY KEY,
    train_num VARCHAR(100) NOT NULL,
    train_model_id INTEGER REFERENCES trains.TRAIN_MODEL (train_model_id)
);

create table trains.TRIP_X_TRAIN
(
    train_id INTEGER REFERENCES trains.TRAIN (train_id),
    trip_id INTEGER REFERENCES trains.TRIP (trip_id)
);

create table trains.PASSENGER
(
    passenger_id INTEGER PRIMARY KEY,
    passenger_family_nm VARCHAR(100) NOT NULL,
    passenger_first_nm VARCHAR(100) NOT NULL,
    passenger_birth_dt DATE
);

create table trains.TICKET
(
    ticket_id INTEGER PRIMARY KEY,
    trip_id INTEGER REFERENCES trains.TRIP (trip_id),
    passenger_id INTEGER REFERENCES trains.PASSENGER (passenger_id),
    wagon_num SMALLINT NOT NULL,
    seat_num SMALLINT NOT NULL,
    price_amt SMALLINT NOT NULL
);

create table trains.PASSPORT_HISTORY
(
    passenger_id INTEGER REFERENCES trains.PASSENGER (passenger_id),
    passport_code BIGINT NOT NULL UNIQUE,
    issuing_dttm TIMESTAMP,
    end_dttm TIMESTAMP
);

---- INSERT BLOCK

-- TABLE: STATION

INSERT INTO trains.STATION
VALUES (1, 'Ленинградский вокзал', 'Москва');
INSERT INTO trains.STATION
VALUES (2, 'Московский вокзал', 'Санкт-Петербург');
INSERT INTO trains.STATION
VALUES (3, 'Киевский вокзал', 'Москва');
INSERT INTO trains.STATION
VALUES (4, 'Савеловский вокзал', 'Москва');
INSERT INTO trains.STATION
VALUES (5, 'Балтийский вокзал', 'Санкт-Петербург');
INSERT INTO trains.STATION
VALUES (6, 'Владивосток', 'Владивосток');
INSERT INTO trains.STATION
VALUES (7, 'Екатеринбург-Пассажирский', 'Екатеринбург');
INSERT INTO trains.STATION
VALUES (8, 'Новосибирск-Главный', 'Новосибирск');
INSERT INTO trains.STATION
VALUES (9, 'Калининград-Южный', 'Калининград');
INSERT INTO trains.STATION
VALUES (10, 'Москва Белорусская', 'Москва');
INSERT INTO trains.STATION
VALUES (11, 'Брянск-Орловский', 'Брянск');
INSERT INTO trains.STATION
VALUES (12, 'Ярославский вокзал', 'Москва');

-- TABLE: TRIP
INSERT INTO  trains.TRIP
VALUES (1, 1, 2, TIMESTAMP '2021-03-08 00:33:51', TIMESTAMP '2021-03-08 09:33:21');
INSERT INTO  trains.TRIP
VALUES (2, 2, 1, TIMESTAMP '2021-03-09 00:33:51', TIMESTAMP '2021-03-09 09:39:21');
INSERT INTO  trains.TRIP
VALUES (3, 12, 8, TIMESTAMP '2021-04-08 00:35:51', TIMESTAMP '2021-04-10 07:55:21');
INSERT INTO  trains.TRIP
VALUES (4, 8, 12, TIMESTAMP '2021-05-08 00:35:51', TIMESTAMP '2021-05-10 07:55:21');
INSERT INTO  trains.TRIP
VALUES (5, 10, 9, TIMESTAMP '2021-04-04 19:53:00', TIMESTAMP '2021-04-05 14:46:00');
INSERT INTO  trains.TRIP
VALUES (6, 9, 10, TIMESTAMP '2021-03-11 19:53:00', TIMESTAMP '2021-03-12 14:46:00');
INSERT INTO  trains.TRIP
VALUES (7, 12, 6, TIMESTAMP '2021-02-04 00:35:00', TIMESTAMP '2021-02-10 06:17:00');
INSERT INTO  trains.TRIP
VALUES (8, 6, 12, TIMESTAMP '2021-04-10 01:53:00', TIMESTAMP '2021-04-16 07:46:00');
INSERT INTO  trains.TRIP
VALUES (9, 12, 7, TIMESTAMP '2021-04-09 19:53:00', TIMESTAMP '2021-04-10 20:46:00');
INSERT INTO  trains.TRIP
VALUES (10, 7, 12, TIMESTAMP '2021-04-14 00:07:00', TIMESTAMP '2021-04-15 01:47:00');

-- TABLE: STATION_X_TRIP

INSERT INTO trains.STATION_X_TRIP
VALUES (1, 1);
INSERT INTO trains.STATION_X_TRIP
VALUES (7, 7);
INSERT INTO trains.STATION_X_TRIP
VALUES (7, 8);
INSERT INTO trains.STATION_X_TRIP
VALUES (8, 7);
INSERT INTO trains.STATION_X_TRIP
VALUES (8, 8);
INSERT INTO trains.STATION_X_TRIP
VALUES (1, 2);
INSERT INTO trains.STATION_X_TRIP
VALUES (2, 1);
INSERT INTO trains.STATION_X_TRIP
VALUES (5, 1);
INSERT INTO trains.STATION_X_TRIP
VALUES (5, 2);
INSERT INTO trains.STATION_X_TRIP
VALUES (6, 8);
INSERT INTO trains.STATION_X_TRIP
VALUES (12, 8);

-- TABLE: PASSENGER

INSERT INTO trains.PASSENGER
VALUES (1, 'Орлов', 'Василий', '1991-09-29');
INSERT INTO trains.PASSENGER
VALUES (2, 'Орлова', 'Мария', '1986-10-20');
INSERT INTO trains.PASSENGER
VALUES (3, 'Николаев', 'Амир', '1964-01-09');
INSERT INTO trains.PASSENGER
VALUES (4, 'Васильева', 'Вера', '1981-02-20');
INSERT INTO trains.PASSENGER
VALUES (5, 'Трубникова', 'Ангелина', '1971-03-29');
INSERT INTO trains.PASSENGER
VALUES (6, 'Тихомиров', 'Григорий', '1995-06-06');
INSERT INTO trains.PASSENGER
VALUES (7, 'Денисова', 'Мария', '1941-10-03');
INSERT INTO trains.PASSENGER
VALUES (8, 'Ишникова', 'Маргарита', '1979-08-29');
INSERT INTO trains.PASSENGER
VALUES (9, 'Русакова', 'Виктория', '1984-07-13');
INSERT INTO trains.PASSENGER
VALUES (10, 'Орлов', 'Николай', '1956-11-21');
INSERT INTO trains.PASSENGER
VALUES (11, 'Кошелева', 'Вероника', '1995-01-01');

-- TABLE: TICKET
INSERT INTO trains.TICKET
VALUES (1, 1, 11, 2, 21, 1020);
INSERT INTO trains.TICKET
VALUES (2, 1, 10, 3, 11, 7000);
INSERT INTO trains.TICKET
VALUES (3, 7, 9, 5, 20, 20120);
INSERT INTO trains.TICKET
VALUES (4, 7, 7, 5, 21, 11220);
INSERT INTO trains.TICKET
VALUES (5, 7, 11, 2, 21, 11020);
INSERT INTO trains.TICKET
VALUES (6, 2, 6, 11, 2, 5020);
INSERT INTO trains.TICKET
VALUES (7, 2, 3, 1, 2, 6020);
INSERT INTO trains.TICKET
VALUES (8, 1, 11, 3, 21, 1020);
INSERT INTO trains.TICKET
VALUES (9, 1, 10, 4, 11, 7000);
INSERT INTO trains.TICKET
VALUES (10, 7, 8, 5, 10, 15000);
INSERT INTO trains.TICKET
VALUES (11, 7, 9, 9, 21, 11000);
INSERT INTO trains.TICKET
VALUES (12, 7, 1, 6, 22, 11000);
INSERT INTO trains.TICKET
VALUES (13, 2, 2, 20, 2, 5020);
INSERT INTO trains.TICKET
VALUES (14, 2, 7, 12, 2, 6020);


-- TABLE: PASSPORT_HISTORY
-- 5999-01-01 00:00:00 == NULL
INSERT INTO trains.PASSPORT_HISTORY
VALUES (3, 4514123478, TIMESTAMP '2014-01-20 09:00:00', TIMESTAMP '5999-01-01 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (3, 4500348899, TIMESTAMP '2000-02-09 09:00:00', TIMESTAMP '2014-02-09 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (1, 4305123456, TIMESTAMP '2005-09-30 09:00:00', TIMESTAMP '2011-10-30 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (2, 4300143456, TIMESTAMP '2000-10-30 09:00:00', TIMESTAMP '2006-11-30 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (2, 4306243496, TIMESTAMP '2006-11-04 09:00:00', TIMESTAMP '2031-11-30 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (4, 4301222345, TIMESTAMP '2001-03-10 09:00:00', TIMESTAMP '2026-03-20 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (5, 4516183456, TIMESTAMP '2016-04-20 09:00:00', TIMESTAMP '5999-01-01 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (6, 4515193459, TIMESTAMP '2015-06-20 09:00:00', TIMESTAMP '2035-07-06 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (6, 4509183006, TIMESTAMP '2009-06-09 09:00:00', TIMESTAMP '2015-07-06 00:00:00');
INSERT INTO trains.PASSPORT_HISTORY
VALUES (11, 4515183456, TIMESTAMP '2015-01-20 09:00:00', TIMESTAMP '2035-02-01 00:00:00');

-- TABLE: TRAIN_MODEL
INSERT INTO trains.TRAIN_MODEL
VALUES (1, 'Россия', 100);
INSERT INTO trains.TRAIN_MODEL
VALUES (2, 'Сапсан', 200);
INSERT INTO trains.TRAIN_MODEL
VALUES (3, 'Янтарь', 90);
INSERT INTO trains.TRAIN_MODEL
VALUES (4, 'Премиум', 110);
INSERT INTO trains.TRAIN_MODEL
VALUES (5, 'Первый класс', 100);
INSERT INTO trains.TRAIN_MODEL
VALUES (6, 'Второй класс', 90);
INSERT INTO trains.TRAIN_MODEL
VALUES (7, 'Россия', 100);
INSERT INTO trains.TRAIN_MODEL
VALUES (8, 'Невский Экспресс', 150);
INSERT INTO trains.TRAIN_MODEL
VALUES (9, 'Стриж', 160);

-- TABLE: TRAIN
INSERT INTO trains.TRAIN
VALUES (1, '714', 9);
INSERT INTO trains.TRAIN
VALUES (2, '768А', 2);
INSERT INTO trains.TRAIN
VALUES (3, '770А', 2);
INSERT INTO trains.TRAIN
VALUES (4, '061М', 4);
INSERT INTO trains.TRAIN
VALUES (5, '061Щ', 4);
INSERT INTO trains.TRAIN
VALUES (6, '002Э', 6);
INSERT INTO trains.TRAIN
VALUES (7, '003Э', 8);
INSERT INTO trains.TRAIN
VALUES (8, '041Щ', 3);
INSERT INTO trains.TRAIN
VALUES (9, '060М', 5);

-- TABLE: TRIP_X_TRAIN
INSERT INTO trains.TRIP_X_TRAIN
VALUES (2, 1);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (2, 2);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (3, 1);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (3, 2);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (8, 5);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (8, 6);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (6, 9);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (9, 10);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (6, 7);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (9, 8);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (4, 4);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (5, 4);

-- 10 INSERTS, DELETE, UPDATE , SELECT запросы
--CRUD запросы - это create, read, update, delete
-- в наших терминах insert, select, update, delete

-- 1) вывести список пассажиров, у которых станция отправления маршрутов == 1 (Ленинградский вокзал)
SELECT passenger_family_nm, passenger_first_nm
FROM trains.PASSENGER p
LEFT JOIN trains.TICKET tk
ON p.passenger_id = tk.passenger_id
LEFT JOIN trains.TRIP tr
ON tk.trip_id = tr.trip_id
WHERE departure_station_id = 1;

-- 2) Добавим нового пассажира
INSERT INTO trains.PASSENGER
VALUES (12, 'Иванова', 'Мария', '1999-10-03');

--- 3) и билет для него
INSERT INTO trains.TICKET
VALUES (15, 2, 12, 12, 1, 6020);

-- 4) Изменим фамилию пассажира
UPDATE trains.PASSENGER
SET passenger_family_nm = 'Александрова'
WHERE passenger_id = 12;

-- 5) Удалим билетик
DELETE
FROM trains.TICKET
WHERE passenger_id = 12;

-- 6) Найдем поездки, где дата отправления в апреле
SELECT *
FROM trains.TRIP
WHERE departure_dttm > '2021-03-31';

--7) Найдем все вокзалы, с которых есть отправления
SELECT DISTINCT station_nm
FROM trains.STATION st
INNER JOIN trains.TRIP tr
ON tr.departure_station_id = st.station_id;

--8) Найдем пассажиров, которые имеют билеты, отсортируем их по фамилии по алфавиту
SELECT DISTINCT passenger_family_nm, passenger_first_nm
FROM trains.PASSENGER p
INNER JOIN trains.TICKET TK
ON p.passenger_id = tk.passenger_id
ORDER BY passenger_family_nm;

--9) Добавим еще данные для поездки
INSERT INTO trains.TRIP
VALUES (11, 11, 3, TIMESTAMP '2021-05-15 00:00:17', TIMESTAMP '2021-05-15 06:10:00');
INSERT INTO trains.TICKET
VALUES (16, 11, 5, 2, 21, 3020);
INSERT INTO trains.TICKET
VALUES (17, 11, 9, 2, 2, 3020);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (6, 11);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (7, 6);
INSERT INTO trains.TRIP_X_TRAIN
VALUES (9, 5);
INSERT INTO trains.STATION_X_TRIP
VALUES (11, 11);
INSERT INTO trains.STATION_X_TRIP
VALUES (9, 6);
INSERT INTO trains.STATION_X_TRIP
VALUES (10, 5);


--10) Найдем, пассажиров, которые потратили на билеты более 5000руб
-- Ожидаем вывод passenger_id: 10, 9, 7, 11, 6, 3, 8, 1, 2 (1, 2, 3, 6, 7, 8, 9, 10, 11)
-- Вывод соответсвует ожиданиям
SELECT p.passenger_id, passenger_family_nm, passenger_first_nm
FROM trains.PASSENGER p
INNER JOIN trains.TICKET tk
ON p.passenger_id = tk.passenger_id
GROUP BY p.passenger_id
HAVING sum(price_amt) > 5000
ORDER BY p.passenger_id;

-- Запросы с использованием GROUP BY, HAVING, ORDER BY, OVER, PARTITION BY
-- 1) Вывести пассажиров, у которых нет билетов, в обратном id порядке
-- Выведет 12 - Александрову и 4 - Васильеву
SELECT p.passenger_id, passenger_family_nm, passenger_first_nm
FROM trains.PASSENGER p
LEFT JOIN trains.TICKET tk
ON p.passenger_id = tk.passenger_id
WHERE ticket_id IS NULL
GROUP BY p.passenger_id
ORDER BY p.passenger_id DESC;

-- 2) Вывести название моделей поездов, которые прибывают на station_id = 6 (Владивосток)
-- Вывод: второй класс
SELECT DISTINCT train_model_nm
FROM trains.TRAIN_MODEL tm
INNER JOIN trains.TRAIN tr
ON tm.train_model_id = tr.train_model_id
INNER JOIN trains.TRIP_X_TRAIN tt
ON tr.train_id = tt.train_id
INNER JOIN trains.TRIP trip
ON tt.trip_id = trip.trip_id
WHERE arrival_station_id = '6';

--3) вывести окном пассажиров, какие билеты покупали, общую сумму от всех билетов для пассажира,
-- билеты внутри расположить по возрастанию цены
-- должен вывести 16 строк, так как 16 билетов, id людей из запроса 10 (совпадают), цены на билеты и общую сумму
SELECT p.passenger_id
       , passenger_family_nm
        , passenger_first_nm
        , price_amt
        , sum(price_amt) OVER (PARTITION BY p.passenger_id ORDER BY price_amt) AS sum_tikets_cost
FROM trains.PASSENGER as p
INNER JOIN trains.TICKET as tk
ON p.passenger_id = tk.passenger_id;

--4) вывести станции, с которых есть отправление поездов, и общее количество поездов
-- У нас 9 уникальных станций отправления, 15 station_x_trip связей. Это и должно выводиться.
SELECT station_nm
        , train_num
     , tr.departure_station_id,
     sum(1) OVER (PARTITION BY station_nm) as all_trains
FROM trains.STATION as st
INNER JOIN trains.TRIP AS tr
ON st.station_id = tr.departure_station_id
INNER JOIN trains.TRIP_X_TRAIN as trns
ON tr.trip_id = trns.trip_id
INNER JOIN trains.TRAIN as train
ON trns.train_id = train.train_id
WHERE departure_station_id IS NOT NULL;

--5) вывести какие модели с каких станций отправляются
-- у одного маршрута могут быть разные поезда, запрос выдает пары (модель, станция), их 14,
-- как и получили.
SELECT DISTINCT train_model_nm, station_nm
FROM trains.TRAIN_MODEL as tm
INNER JOIN trains.TRAIN as trn
ON tm.train_model_id = trn.train_model_id
INNER JOIN trains.TRIP_X_TRAIN txt
ON trn.train_id = txt.train_id
INNER JOIN trains.TRIP as tr
ON txt.trip_id = tr.trip_id
INNER JOIN trains.STATION_X_TRIP
ON tr.trip_id = station_x_trip.trip_id
INNER JOIN trains.STATION st
ON station_x_trip.station_id = st.station_id
ORDER BY train_model_nm;


--6) выводит человека и время с момента предыдущей поездки, null, если не было поездок
SELECT
  passenger_family_nm,
    passenger_first_nm,
    station_nm,
    departure_dttm,
    age(departure_dttm, lag(departure_dttm, 1) OVER (PARTITION BY psg.passenger_id ORDER BY departure_dttm)) as time_from_last_trip
FROM trains.PASSENGER psg
INNER JOIN trains.TICKET tick
ON psg.passenger_id = tick.passenger_id
INNER JOIN trains.TRIP tr
ON tick.trip_id = tr.trip_id
INNER JOIN trains.STATION st
ON st.station_id = tr.departure_station_id;

-- 7)  выводит человека, станцию отправления, время отправления и номер поездки
SELECT
  passenger_family_nm,
    passenger_first_nm,
    station_nm,
    departure_dttm,
    ROW_NUMBER() OVER (PARTITION BY psg.passenger_id ORDER BY departure_dttm) as passenger_trip_number
FROM trains.PASSENGER psg
INNER JOIN trains.TICKET tick
ON psg.passenger_id = tick.passenger_id
INNER JOIN trains.TRIP tr
ON tick.trip_id = tr.trip_id
INNER JOIN trains.STATION st
ON st.station_id = tr.departure_station_id;


--- 8) VIEWS
--DROP VIEW trains.v_passenger_info;

-- 1)Выводит информацию о пассажирах и их дате рождения, оставляя только год и
-- скрывая месяц и день
CREATE OR REPLACE VIEW trains.v_PASSENGER_INFO AS
SELECT passenger_family_nm
     , passenger_first_nm
     , to_char(passenger_birth_dt, 'YYYY') || '-XX-XX' AS birth_dt
FROM trains.PASSENGER;

SELECT *
FROM trains.v_PASSENGER_INFO;


--2) Вывести пассажиров, у которых паспорт действует позднее 01.01.2005, вывести
-- первую и последнюю цифры кода паспорта, остальные скрыть
CREATE OR REPLACE VIEW trains.v_PASSENGER_PASSPORT_INFO AS
SELECT passenger_family_nm
    , passenger_first_nm
    , left(to_char(passport_code, '0000000000'), 2) || 'XXXXXXXX' ||
      right(to_char(passport_code, '0000000000'), 1) AS passport
FROM trains.PASSENGER as p
INNER JOIN trains.PASSPORT_HISTORY as ph
ON p.passenger_id = ph.passenger_id
WHERE issuing_dttm > '2005-01-01';

SELECT *
FROM trains.v_PASSENGER_PASSPORT_INFO;

--3) Вывести, сколько потратил каждый пассажир на все билеты
CREATE VIEW trains.v_TRIPS_INFO AS
    SELECT passenger_family_nm
        ,passenger_first_nm
        , sum(price_amt)
FROM trains.PASSENGER as p
LEFT JOIN trains.TICKET as tk
ON p.passenger_id = tk.passenger_id
GROUP BY passenger_family_nm, passenger_first_nm;

SELECT *
FROM trains.v_TRIPS_INFO;

--4) Вывести станции и количество поездов, которое с них отправлялось
CREATE VIEW trains.v_TRAINS_DEPATURES_INFO AS
    SELECT station_nm
        , count(*)
FROM trains.STATION as st
LEFT JOIN trains.TRIP as tr
ON st.station_id = tr.departure_station_id
GROUP BY station_nm;

SELECT *
FROM trains.v_TRAINS_DEPATURES_INFO;

--5) Вывести, какие модели поездов с каких станций отправляются, без значений NULL
CREATE VIEW trains.v_MODELS_DEPATURES_INFO AS
    SELECT train_model_nm
        , station_nm
FROM trains.TRAIN_MODEL as tm
INNER JOIN trains.TRAIN as trn
ON tm.train_model_id = trn.train_model_id
INNER JOIN trains.TRIP_X_TRAIN tt
ON trn.train_id = tt.train_id
INNER JOIN trains.TRIP trip
ON tt.trip_id = trip.trip_id
INNER JOIN trains.STATION as st
ON trip.departure_station_id = st.station_id
GROUP BY train_model_nm, station_nm;

SELECT *
FROM trains.v_MODELS_DEPATURES_INFO;

--6) вывести номера поездов и на какие станции они прибывают без значений NULL
CREATE VIEW trains.v_TRAIN_NUMS_ARRIVAL_INFO AS
    SELECT train_num
        , station_nm
FROM trains.TRAIN as trn
INNER JOIN trains.TRIP_X_TRAIN tt
ON trn.train_id = tt.train_id
INNER JOIN trains.TRIP trip
ON tt.trip_id = trip.trip_id
INNER JOIN trains.STATION as st
ON trip.arrival_station_id = st.station_id
GROUP BY train_num, station_nm;

SELECT *
FROM trains.v_TRAIN_NUMS_ARRIVAL_INFO;

-- ФУНКЦИИ И ТРИГГЕРЫ, ЗАДАНИЯ 9-10
--1) функция, которая принимает месяц и выдает все поездки (+ станцию отправления), которые совершались
-- в этот месяц(если он уже прошел)
CREATE OR REPLACE FUNCTION Trips(month SMALLINT)
  RETURNS TABLE
          (
            trip_id INTEGER,
            departure_station_nm VARCHAR(100)
          )
AS
$$
BEGIN
  IF month > date_part('month', current_date) THEN
    RAISE EXCEPTION 'This month is more than current month';
  END IF;

  IF month <= 0 OR month > 12 THEN
    RAISE EXCEPTION 'Invalid number of month';
  END IF;

  RETURN QUERY SELECT tr.trip_id
                    , st.station_nm
               FROM trains.TRIP as tr
                INNER JOIN trains.STATION as st
                ON tr.departure_station_id = st.station_id
               WHERE date_part('month', tr.departure_dttm) = month;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM Trips(cast(4 as smallint));


--2) Функция, которая принимает пассажира и месяц, выводит все поездки, которые он совершал за этот месяц
--(или будет совершать, если месяц еще не прошел)
CREATE OR REPLACE FUNCTION Passenger_and_Trips(passenger VARCHAR(100), month SMALLINT)
  RETURNS TABLE
          (
            passenger_family_nm VARCHAR(100),
            passenger_first_nm VARCHAR(100),
            trip_id INTEGER,
            departure_station_nm VARCHAR(100),
            arrival_station_nm VARCHAR(100)
          )
AS
$$
BEGIN
  IF month <= 0 OR month > 12 THEN
    RAISE EXCEPTION 'Invalid number of month';
  END IF;

  RETURN QUERY SELECT p.passenger_family_nm
                      , p.passenger_first_nm
                      , tr.trip_id
                      , dst.station_nm
                      , ast.station_nm
                FROM trains.PASSENGER AS p
                    INNER JOIN trains.TICKET
                    ON p.passenger_id = ticket.passenger_id
               INNER JOIN trains.TRIP as tr
                ON ticket.trip_id = tr.trip_id
                INNER JOIN trains.STATION as dst
                ON tr.departure_station_id = dst.station_id
                INNER JOIN trains.STATION as ast
                ON tr.arrival_station_id = ast.station_id
               WHERE p.passenger_family_nm = passenger AND date_part('month', tr.departure_dttm) = month;
END;
$$ LANGUAGE plpgsql;

SELECT *
FROM Passenger_and_Trips('Орлова', cast(3 as smallint));

-- TRIGGERS
--1) проверяем информацию, которая заносится в таблицу PASSPORT_HISTORY
-- Хотим, чтобы у паспорта код был ровно 10 чиселок в бигинт, чтобы между датой окончания и датой выхода нового паспорта
-- было +-30 дней и чтобы дата окончания паспорта была больше даты выхода
CREATE FUNCTION trains.PASSPORT_HISTORY_stamp() RETURNS trigger AS
$PASSPORT_HISTORY_stamp$
BEGIN
  IF NEW.end_dttm < NEW.issuing_dttm THEN
    RAISE EXCEPTION 'END_DTTM can not be less than ISSUING_DTTM';
  END IF;

  IF (SELECT count(*)
      FROM trains.PASSPORT_HISTORY AS p
      WHERE p.passenger_id = NEW.passenger_id
        AND (date_part('day', age(p.end_dttm, NEW.issuing_dttm)) > 30
                OR  date_part('day', age(NEW.issuing_dttm, p.end_dttm)) > 30)) THEN
    RAISE EXCEPTION 'time segment intersects with some from table PASSPORT_HISTORY';
  END IF;

  IF LENGTH( NEW.passport_code::text) != 10 THEN
      RAISE EXCEPTION 'PASSPORT CODE IS NOT CORRECT';
  END IF;
  return NEW;
END;
$PASSPORT_HISTORY_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER PASSPORT_HISTORY_stamp
  BEFORE INSERT OR UPDATE
  ON trains.PASSPORT_HISTORY
  FOR EACH ROW
EXECUTE PROCEDURE trains.PASSPORT_HISTORY_stamp();

DROP FUNCTION trains.PASSPORT_HISTORY_stamp() CASCADE;
DROP TRIGGER PASSPORT_HISTORY_stamp ON trains.PASSPORT_HISTORY;

-- Проверка работы триггера:

UPDATE trains.PASSPORT_HISTORY
SET passport_code = 45
WHERE passenger_id = 6
  AND issuing_dttm = '2015-06-20 09:00:00';
-- тут код не корректный

INSERT INTO trains.PASSPORT_HISTORY
VALUES (9, 4510345678, TIMESTAMP '2010-01-20 09:00:00', TIMESTAMP '5999-01-01 00:00:00');
-- тут все сработает

SELECT *
FROM trains.PASSPORT_HISTORY;

--2) Проверяем, что в таблице TICKET не было такого, чтобы два пассажира сидели на одном месте
CREATE FUNCTION trains.TICKET_stamp() RETURNS trigger AS
$TICKET_stamp$
BEGIN
   IF (SELECT count(*)
      FROM trains.TICKET AS p
      WHERE p.passenger_id != NEW.passenger_id
        AND (p.trip_id = NEW.trip_id AND
             p.wagon_num = NEW.wagon_num AND
             p.seat_num = NEW.seat_num)) THEN
    RAISE EXCEPTION 'TWO PASSENGERS CAN NOT SEAT ON ONE PLACE';
  END IF;
  return NEW;
END;
$TICKET_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER TICKET_stamp
  BEFORE INSERT OR UPDATE
  ON trains.TICKET
  FOR EACH ROW
EXECUTE PROCEDURE trains.TICKET_stamp();

DROP FUNCTION trains.TICKET_stamp() CASCADE;
DROP TRIGGER TICKET_stamp ON trains.TICKET;

--Проверка триггера
INSERT INTO trains.TICKET
VALUES (20, 1, 12, 2, 21, 1050);
-- не получится вставить
