-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 03, 2024 at 08:58 AM
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
-- Table structure for table `ung_few_user`
--

CREATE TABLE `ung_few_user` (
  `id` int(11) NOT NULL,
  `customerId` text NOT NULL,
  `address` text NOT NULL,
  `customerName` text NOT NULL,
  `lastName` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `lat` text NOT NULL,
  `lng` text NOT NULL,
  `status` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ung_few_user`
--

INSERT INTO `ung_few_user` (`id`, `customerId`, `address`, `customerName`, `lastName`, `phoneNumber`, `lat`, `lng`, `status`, `email`, `password`) VALUES
(1, 'cus-206', '567/789 หมู่บ้านถาวร บางนา Thailand', 'โดรามอน', 'ญี่ปุ่นซามูไร', '0811234567', '13.6677846', '100.6216595', 'user', 'dora@abc.com', '123456'),
(2, 'cus-72', '123/4567 BKK', 'Nopita', 'Japan', '0811123456', '13.6677849', '100.6216624', 'user', 'nopi@abc.com', '123456'),
(3, 'cus-665', '123/456 บางนา กรุงเทพ', 'โดมอน นะเนี่ย', 'เจแพน Test', '0811234569', '13.6677842', '100.6216689', 'user', 'domon@abc.com', '123456'),
(4, 'cus-827', '123/2321 BBKK', 'สมชาย', 'SurnameOfficer', '0811233212', '13.6677839', '100.621664', 'user', 'admin1@abc.com', '123456'),
(5, 'cus-828', '123/2321 BBKK', 'สมพร', 'SurnameOfficer', '0811233212', '13.6677839', '100.621664', 'user', 'admin2@abc.com', '123456'),
(6, 'cus-829', '123/2321 BBKK', 'สมหวัง', 'SurnameOfficer', '0811233212', '13.6677839', '100.621664', 'user', 'admin3@abc.com', '123456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ung_few_user`
--
ALTER TABLE `ung_few_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ung_few_user`
--
ALTER TABLE `ung_few_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
