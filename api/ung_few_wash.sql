-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 03, 2024 at 09:00 AM
-- Server version: 10.6.17-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `androidh_fluttertraining`
--

-- --------------------------------------------------------

--
-- Table structure for table `ung_few_wash`
--

CREATE TABLE `ung_few_wash` (
  `id` int(11) NOT NULL,
  `refWash` text NOT NULL,
  `customerId` text NOT NULL,
  `dateStart` text NOT NULL,
  `timeStar` text NOT NULL,
  `dateEnd` text NOT NULL,
  `timeEnd` text NOT NULL,
  `dry` text NOT NULL,
  `amountCloth` text NOT NULL,
  `detergen` text NOT NULL,
  `softener` text NOT NULL,
  `total` text NOT NULL,
  `status` text NOT NULL,
  `idAdminReceive` text NOT NULL,
  `idAdminOrder` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ung_few_wash`
--

INSERT INTO `ung_few_wash` (`id`, `refWash`, `customerId`, `dateStart`, `timeStar`, `dateEnd`, `timeEnd`, `dry`, `amountCloth`, `detergen`, `softener`, `total`, `status`, `idAdminReceive`, `idAdminOrder`) VALUES
(1, 'ref-7109', 'cus-206', '26 / Aug / 24', '08:00', '26 / Aug / 24', '18:00', 'true', '5', '1', '1', '125', 'Receive', '5', '$idAdminOrder'),
(2, 'ref-4800', 'cus-206', '28 / Aug / 24', '08:00', '28 / Aug / 24', '19:30', 'true', '5', '3', '3', '165', 'Receive', '5', ''),
(3, 'ref-2137', 'cus-206', '30 / Aug / 24', '08:00', '31 / Aug / 24', '12:00', 'true', '3', '2', '1', '125', 'Receive', '', ''),
(4, 'ref-9596', 'cus-206', '02 / Sep / 24', '12:00', '03 / Sep / 24', '18:00', 'true', '10', '5', '4', '220', 'Receive', '', ''),
(5, 'ref-7160', 'cus-206', '08 / Sep / 24', '08:00', '09 / Sep / 24', '08:00', 'true', '3', '1', '2', '125', 'Order', '', ''),
(6, 'ref-4096', 'cus-206', '12 / Sep / 24', '08:00', '13 / Sep / 24', '08:00', 'true', '12', '1', '1', '160', 'Order', '', ''),
(7, 'ref-2257', 'cus-206', '14 / Sep / 24', '08:00', '15 / Sep / 24', '08:00', 'true', '2', '1', '1', '110', 'Order', '', ''),
(8, 'ref-5429', 'cus-206', '15 / Sep / 24', '10:00', '15 / Sep / 24', '19:30', 'true', '2', '2', '2', '130', 'Order', '', ''),
(9, 'ref-2928', 'cus-206', '10 / Sep / 24', '10:00', '12 / Sep / 24', '10:00', 'false', '7', '2', '1', '105', 'Order', '', ''),
(10, 'ref-6583', 'cus-206', '27 / Aug / 24', '10:00', '28 / Aug / 24', '16:00', 'false', '7', '1', '1', '95', 'Order', '', ''),
(11, 'ref-2482', 'cus-206', '29 / Aug / 24', '12:00', '31 / Aug / 24', '10:00', 'true', '7', '1', '1', '135', 'Order', '', ''),
(12, 'ref-8452', 'cus-206', '27 / Aug / 24', '10:00', '29 / Aug / 24', '10:00', 'true', '7', '2', '3', '165', 'Order', '', ''),
(13, 'ref-1722', 'cus-72', '25 / Aug / 24', '18:00', '26 / Aug / 24', '08:00', 'true', '12', '5', '5', '240', 'Order', '', ''),
(14, 'ref-243', 'cus-206', '23 / Sep / 24', '08:00', '24 / Sep / 24', '19:30', 'true', '9', '2', '3', '175', 'Order', '', ''),
(15, 'ref-7072', 'cus-72', '02 / Sep / 24', '16:00', '03 / Sep / 24', '08:00', 'true', '10', '5', '5', '230', 'Order', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ung_few_wash`
--
ALTER TABLE `ung_few_wash`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ung_few_wash`
--
ALTER TABLE `ung_few_wash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
