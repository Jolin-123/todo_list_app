-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2023 at 02:56 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `431fin_linjiu_new`
--
CREATE DATABASE IF NOT EXISTS `431fin_linjiu_new` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `431fin_linjiu_new`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `change_item_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_item_status` (IN `input_idx` INT(11))   BEGIN
 
     UPDATE item SET checked = 1 WHERE idx = input_idx;

END$$

DROP PROCEDURE IF EXISTS `delete_item`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_item` (IN `input_idx` INT(11))   BEGIN

	DELETE FROM `item` WHERE idx=input_idx;

END$$

DROP PROCEDURE IF EXISTS `delete_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_list` (IN `input_idx` INT(11))   BEGIN
  
    DELETE FROM `list` WHERE idx= input_idx;

END$$

DROP PROCEDURE IF EXISTS `get_lists`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lists` ()   BEGIN

	SELECT * FROM `list` ORDER BY created DESC;
    
END$$

DROP PROCEDURE IF EXISTS `get_list_items`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_items` (IN `item_idx` INT)   BEGIN

    SELECT * FROM `item` WHERE `item`.`list_idx` = item_idx;
    
 
 END$$

DROP PROCEDURE IF EXISTS `insert_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_list` (IN `input_listname` VARCHAR(512))   BEGIN

    INSERT INTO `list` (name) VALUES (input_listname);

END$$

DROP PROCEDURE IF EXISTS `insert_new_item`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_item` (IN `input_list_idx` INT(11), IN `input_text` VARCHAR(512))   BEGIN

  INSERT INTO `item` (list_idx, text) VALUES (input_list_idx, input_text );

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `idx` int(11) NOT NULL,
  `text` varchar(512) NOT NULL,
  `checked` tinyint(1) NOT NULL DEFAULT 0,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `list_idx` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`idx`, `text`, `checked`, `created`, `list_idx`) VALUES
(1, 'bean', 1, '2023-05-18 23:12:10', 1),
(11, 'apple1', 1, '2023-05-19 02:37:25', 1),
(12, 'apple2', 0, '2023-05-19 02:37:25', 1),
(13, 'apple3', 0, '2023-05-19 02:37:25', 1),
(14, 'cookie1', 0, '2023-05-19 02:37:25', 5),
(15, 'cookie2', 0, '2023-05-19 02:37:25', 5),
(16, 'cookie3', 0, '2023-05-19 02:37:25', 5),
(17, 'flower1', 0, '2023-05-19 02:37:25', 2),
(18, 'flower2', 0, '2023-05-19 02:37:25', 2),
(19, 'flower3', 0, '2023-05-19 02:37:25', 2),
(20, 'flower4', 0, '2023-05-19 02:37:25', 2);

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
  `idx` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`idx`, `name`, `created`) VALUES
(1, 'Monday Demo', '2023-05-18 22:42:20'),
(2, 'Shopping', '2023-05-18 22:42:20'),
(5, 'FRIDAY', '2023-05-19 00:04:57'),
(6, 'Thur', '2023-05-19 04:37:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`idx`),
  ADD KEY `list_idx_fk` (`list_idx`);

--
-- Indexes for table `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`idx`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `idx` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `list`
--
ALTER TABLE `list`
  MODIFY `idx` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `list_idx_fk` FOREIGN KEY (`list_idx`) REFERENCES `list` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
