-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 28, 2024 at 10:38 AM
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
-- Table structure for table `few_user`
--

CREATE TABLE `few_user` (
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
-- Dumping data for table `few_user`
--

INSERT INTO `few_user` (`id`, `customerId`, `address`, `customerName`, `lastName`, `phoneNumber`, `lat`, `lng`, `status`, `email`, `password`) VALUES
(1, 'cus-330', 'xxx/456', 'test01', 'test011', '0928133081', '37.4219983', '-122.084', 'user', 'few@abc.com', '123456'),
(2, 'cus-476', 'fff/555', 'pang01', 'pang011', '0928133082', '37.4219983', '-122.084', 'user', 'pang@abc.com', '123456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `few_user`
--
ALTER TABLE `few_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `few_user`
--
ALTER TABLE `few_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
