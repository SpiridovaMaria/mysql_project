-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 15 2024 г., 21:16
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bd_laba_9`
--

-- --------------------------------------------------------

--
-- Структура таблицы `airlines`
--

CREATE TABLE `airlines` (
  `code` varchar(2) NOT NULL,
  `title` varchar(100) NOT NULL,
  `type` varchar(200) NOT NULL,
  `fleet_size` int(11) NOT NULL,
  `parent_company` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `airlines`
--

INSERT INTO `airlines` (`code`, `title`, `type`, `fleet_size`, `parent_company`) VALUES
('DP', 'Победа', 'лоукостер', 37, 'Группа «Аэрофлот»'),
('N4', 'Nordwind Airlines', 'ООО', 27, 'Pegas Touristik'),
('S7', 'S7 Airlines', 'акционерное общество', 100, 'S7 Group'),
('SU', 'Аэрофлот', 'публичное акционерное общество', 177, ''),
('U6', 'Уральские авиалинии', 'акционерное общество открытого типа ', 54, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `class`
--

INSERT INTO `class` (`id`, `name`, `price`) VALUES
(0, 'first', 50000),
(1, 'business', 20000),
(2, 'economy', 5000);

-- --------------------------------------------------------

--
-- Структура таблицы `flights`
--

CREATE TABLE `flights` (
  `number_of_flight` int(11) NOT NULL,
  `date_of_flight` date NOT NULL,
  `time_of_flight` time NOT NULL,
  `check_in` varchar(50) NOT NULL,
  `registration` tinyint(1) NOT NULL,
  `airline` varchar(2) NOT NULL
) ;

--
-- Дамп данных таблицы `flights`
--

INSERT INTO `flights` (`number_of_flight`, `date_of_flight`, `time_of_flight`, `check_in`, `registration`, `airline`) VALUES
(12, '2023-12-20', '15:12:00', '', 0, 'SU'),
(100, '2023-12-11', '23:31:00', '1-10', 1, 'S7'),
(111, '2023-12-13', '02:15:00', '10', 1, 'DP'),
(222, '2023-12-16', '16:31:00', '25-30', 1, 'S7'),
(754, '2023-12-12', '23:31:00', '', 0, 'SU');

-- --------------------------------------------------------

--
-- Структура таблицы `passangers`
--

CREATE TABLE `passangers` (
  `passport_number` bigint(10) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `patronymic` varchar(100) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile_phone` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `passangers`
--

INSERT INTO `passangers` (`passport_number`, `surname`, `name`, `patronymic`, `date_of_birth`, `email`, `mobile_phone`) VALUES
(5216767574, 'Pab', 'Mihail', 'Fedorovich', '1956-12-21', NULL, NULL),
(5217778899, 'Spiridonova', 'Maria', 'Arkadievna', '2003-07-24', 'spiridonova@mail.ru', '+79998887766'),
(5218443311, 'Morozov', 'Vadim', 'Igorevich', '2001-08-30', 'morozov@gmail.com', '+79137712345'),
(5218465432, 'Gabova', 'Victoria', 'Vladimirovna', '1983-07-24', 'gabova@mail.ru', '+79998884321'),
(5220432154, 'Berezova', 'Alena', 'Alexandrovna', '1967-11-30', 'berezova@mail.ru', '+79043124546');

-- --------------------------------------------------------

--
-- Структура таблицы `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `flight_number` int(11) NOT NULL,
  `passenger_passport` bigint(10) NOT NULL,
  `with_baggage` tinyint(1) NOT NULL,
  `baggage_weight` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ;

--
-- Дамп данных таблицы `tickets`
--

INSERT INTO `tickets` (`id`, `flight_number`, `passenger_passport`, `with_baggage`, `baggage_weight`, `class_id`) VALUES
(1, 111, 5220432154, 1, 10, 2),
(2, 754, 5218443311, 1, 10, 2),
(3, 111, 5217778899, 0, 0, 1),
(15, 222, 5220432154, 1, 25, 0),
(16, 100, 5218443311, 0, 0, 2),
(32, 754, 5218465432, 1, 10, 0),
(33, 754, 5216767574, 0, 0, 0);

--
-- Триггеры `tickets`
--
DELIMITER $$
CREATE TRIGGER `baggage_weight_trigger` BEFORE INSERT ON `tickets` FOR EACH ROW BEGIN
IF NEW.baggage_weight>0 AND NEW.baggage_weight<11 THEN 	 
SET NEW.baggage_weight = 10; 
ELSEIF NEW.baggage_weight>10 AND NEW.baggage_weight<16 THEN 	 
SET NEW.baggage_weight = 15;
ELSEIF NEW.baggage_weight>15 AND NEW.baggage_weight<21 THEN 	 
SET NEW.baggage_weight = 20;
ELSEIF NEW.baggage_weight>20 THEN 	 
SET NEW.baggage_weight = 25;
ELSE 
SET NEW.baggage_weight = 0; 
END IF;  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `baggage_weight_upd_trigger` BEFORE UPDATE ON `tickets` FOR EACH ROW BEGIN
IF NEW.baggage_weight>0 AND NEW.baggage_weight<11 THEN 	 
SET NEW.baggage_weight = 10; 
ELSEIF NEW.baggage_weight>10 AND NEW.baggage_weight<16 THEN 	 
SET NEW.baggage_weight = 15;
ELSEIF NEW.baggage_weight>15 AND NEW.baggage_weight<21 THEN 	 
SET NEW.baggage_weight = 20;
ELSEIF NEW.baggage_weight>20 THEN 	 
SET NEW.baggage_weight = 25;
ELSE 
SET NEW.baggage_weight = 0; 
END IF;  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `price_count_trigger` AFTER INSERT ON `tickets` FOR EACH ROW BEGIN
SET @sum = 0;
if NEW.class_id = 0 THEN
SET @sum = 50000;
ELSEIF NEW.class_id = 1 THEN
SET @sum = 20000;
ELSE
SET @sum = 5000;
end if;
if NEW.baggage_weight = 10 THEN
SET @sum = @sum+1000;
elseif NEW.baggage_weight = 15 THEN
SET @sum = @sum+2000;
elseif NEW.baggage_weight = 20 THEN
SET @sum = @sum+3000;
elseif NEW.baggage_weight = 25 THEN
SET @sum = @sum+4000;
end if;
INSERT INTO transactions (id_ticket, passanger_id, final_price) VALUES (NEW.id, NEW.passenger_passport, @sum);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `id_ticket` int(11) NOT NULL,
  `passanger_id` bigint(10) NOT NULL,
  `final_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `transactions`
--

INSERT INTO `transactions` (`id`, `id_ticket`, `passanger_id`, `final_price`) VALUES
(1, 15, 5220432154, 54000),
(2, 16, 5218443311, 5000),
(10, 1, 5220432154, 6000),
(11, 3, 5217778899, 20000),
(13, 2, 5218443311, 6000),
(14, 32, 5218465432, 51000),
(15, 33, 5216767574, 50000);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `airlines`
--
ALTER TABLE `airlines`
  ADD PRIMARY KEY (`code`);

--
-- Индексы таблицы `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`number_of_flight`),
  ADD KEY `airline` (`airline`);

--
-- Индексы таблицы `passangers`
--
ALTER TABLE `passangers`
  ADD PRIMARY KEY (`passport_number`);

--
-- Индексы таблицы `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `passenger_passport` (`passenger_passport`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `flight_number` (`flight_number`);

--
-- Индексы таблицы `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`airline`) REFERENCES `airlines` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`passenger_passport`) REFERENCES `passangers` (`passport_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`flight_number`) REFERENCES `flights` (`number_of_flight`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
