-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 25, 2024 at 01:43 PM
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
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ung_few_wash`
--

INSERT INTO `ung_few_wash` (`id`, `refWash`, `customerId`, `dateStart`, `timeStar`, `dateEnd`, `timeEnd`, `dry`, `amountCloth`, `detergen`, `softener`, `total`, `status`) VALUES
(1, 'ref-7109', 'cus-206', '26 / Aug / 24', '08:00', '26 / Aug / 24', '18:00', 'true', '5', '1', '1', '125', 'Order'),
(2, 'ref-4800', 'cus-206', '28 / Aug / 24', '08:00', '28 / Aug / 24', '19:30', 'true', '5', '3', '3', '165', 'Order');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
