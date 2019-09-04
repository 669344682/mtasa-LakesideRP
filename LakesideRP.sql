-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 03. Sep 2019 um 17:28
-- Server-Version: 5.7.27-0ubuntu0.18.04.1
-- PHP-Version: 7.2.19-0ubuntu0.18.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `LakesideRP`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `changelogs`
--

CREATE TABLE `changelogs` (
  `SortID` int(11) NOT NULL DEFAULT '0',
  `Version` varchar(11) NOT NULL DEFAULT '0',
  `Changes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `changelogs`
--

INSERT INTO `changelogs` (`SortID`, `Version`, `Changes`) VALUES
(999967, '4.1', '+New Register-panel ~Login-panel #Inventory bug #reload bug'),
(999968, '4.0', '+Login Changelogs #Intro bug'),
(999969, '3.9.1', '#/me chat #Teamchat(not for civilian)'),
(999970, '3.9', '+Buy/Sell farm items(Apples(AppleSeeds)&WeedSeeds) +Buy/Sell farm item blip +Pickaxe image(Hud)'),
(999971, '3.8', '+House rent system +House un/lock system #many bugs'),
(999972, '3.7', '+Localtime display +1 item(Cocaine) +Cocaine effect +Inventory Info'),
(999973, '3.6', '+Fishing blip +Gangtag system #Fishing marker #many bugs'),
(999974, '3.5', '+Factionpayday system +Fishing system +4 items(Fishingrod,Bait,Fishinghook&Trout)'),
(999975, '3.4', '+Ammunation +Car radio +Locate player for State +Factionsettings #Wanted PC'),
(999976, '3.3', '+Settings(Radar) +Settings(Shader) +Christmas event(for christmas) +2items(Candycane&Present)'),
(999977, '3.2', '+AFK system +Weather system with Disasters +GunLicense questionnaire +Lotto system'),
(999978, '3.1', '+Megaphone for State-vehicles +Pickaxe sound +Animation panel +Walk animation'),
(999979, '3.0', '+Moon system +Moonloot +Tollgates +3 items(Armor,Pickaxe&Moonstone) ~Mod loader UI'),
(999980, '2.9', '+Taxidriver job +GTAV infobox(for money) #Plant system'),
(999981, '2.8', '+Typing icon under nametag +Joblevel&EXP ~Job center'),
(999982, '2.7', '+Interaction menu +State Interaction menu ~Dead system #many bugs'),
(999983, '2.6', '+3 items(Apple,AppleSeeds&Cigarettes) +More weed-dealer positions +Modloader'),
(999984, '2.5', '+Carlock sound inside +Urin system +Lowering tune #cursor bug'),
(999985, '2.4', '+Weapon icon +ammo in Hud +New skins +Ped stats +Faction-vehicle list in Faction-panel #many bugs'),
(999986, '2.3', '+Custom weapon shoot/reload sounds +Gang-shop(Weapons and skins) +Gang-vehicle dealer'),
(999987, '2.2', '+Note&Respawn function in faction-panel +Ballas(Faction) #many bugs'),
(999988, '2.1', '+Weed dealer +Weaponbox +Grovestreet(Faction) +Factiondepot'),
(999989, '2.0', '+Plant system +Items(Weed&WeedSeeds) +Weedeffect sound #many bugs'),
(999990, '1.9', '~Drawdistance of objects ~Login/Register #many bugs'),
(999991, '1.8', '+ Trunk system + Intro system ~ Tankstation(Marker to Peds)'),
(999992, '1.7', '+ 2 skins + Factionvehicle park function ~ Hospital deathcamera # many bugs'),
(999993, '1.6', '+ Wanteds + Wanted PC + more skin mods'),
(999994, '1.5', '+ Save weapons + F.B.I Faction'),
(999995, '1.4', '+ Drivingschool Company + Car&Bike license + Car&Bike license points'),
(999996, '1.3', '+ Skinshop'),
(999997, '1.2', '+ Blinker sound # Blinker'),
(999998, '1.1', '~ Hud # Save health/Armor'),
(999999, '1.0', '~ Faction/Company skins (1 Male and 1 Female per Faction/Company)');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `companyvehicles`
--

CREATE TABLE `companyvehicles` (
  `ID` int(11) NOT NULL,
  `Owner` mediumint(5) NOT NULL,
  `VehID` smallint(3) NOT NULL,
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `RotX` varchar(20) NOT NULL,
  `RotY` varchar(20) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Fuel` smallint(3) NOT NULL DEFAULT '100',
  `Plate` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `companyvehicles`
--

INSERT INTO `companyvehicles` (`ID`, `Owner`, `VehID`, `SpawnX`, `SpawnY`, `SpawnZ`, `RotX`, `RotY`, `RotZ`, `Fuel`, `Plate`) VALUES
(1, 1, 525, '872.8', '-1175.1', '16.8', '0', '0', '270', 92, '0'),
(2, 1, 525, '872.8', '-1180.7', '16.8', '0', '0', '270', 100, '0'),
(3, 1, 525, '872.8', '-1186.3', '16.8', '0', '0', '270', 100, '0'),
(4, 1, 525, '872.8', '-1192.0', '16.8', '0', '0', '270', 88, '0'),
(5, 1, 525, '872.8', '-1197.6', '16.8', '0', '0', '270', 98, '0'),
(30, 2, 405, '1361.8', '-1658.9', '13.7', '0', '0', '270', 97, '0'),
(31, 2, 405, '1361.8', '-1651.1', '13.7', '0', '0', '270', 95, '0'),
(32, 2, 405, '1361.8', '-1643.3', '13.7', '0', '0', '270', 89, '0'),
(33, 2, 405, '1361.8', '-1635.6', '13.7', '0', '0', '270', 100, '0');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factiondepots`
--

CREATE TABLE `factiondepots` (
  `Faction` mediumint(5) NOT NULL DEFAULT '0',
  `Money` int(50) NOT NULL DEFAULT '0',
  `Weed` int(50) NOT NULL DEFAULT '0',
  `Mats` int(50) NOT NULL DEFAULT '0',
  `Notes` text NOT NULL,
  `Rang1` int(11) NOT NULL DEFAULT '0',
  `Rang2` int(11) NOT NULL DEFAULT '0',
  `Rang3` int(11) NOT NULL DEFAULT '0',
  `Rang4` int(11) NOT NULL DEFAULT '0',
  `Rang5` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factiondepots`
--

INSERT INTO `factiondepots` (`Faction`, `Money`, `Weed`, `Mats`, `Notes`, `Rang1`, `Rang2`, `Rang3`, `Rang4`, `Rang5`) VALUES
(1, 0, 0, 0, 'L.S.P.D', 1, 2, 3, 4, 5),
(2, 0, 0, 0, 'F.B.I', 1, 2, 3, 4, 5),
(3, 0, 0, 0, 'Grove', 1, 2, 3, 4, 5),
(4, 0, 0, 0, 'Ballas', 1, 2, 3, 4, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factiontags`
--

CREATE TABLE `factiontags` (
  `ID` int(70) NOT NULL,
  `SpawnX` varchar(50) NOT NULL,
  `SpawnY` varchar(50) NOT NULL,
  `SpawnZ` varchar(50) NOT NULL,
  `SpawnOX` varchar(50) NOT NULL,
  `SpawnOY` varchar(50) NOT NULL,
  `SpawnOZ` varchar(50) NOT NULL,
  `SpawnOROT` varchar(50) NOT NULL,
  `Owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factiontags`
--

INSERT INTO `factiontags` (`ID`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnOX`, `SpawnOY`, `SpawnOZ`, `SpawnOROT`, `Owner`) VALUES
(1, '2258.8', '-1669.5', '14.4', '2258.8', '-1670.3', '15.6', '0', 0),
(2, '2111.5', '-1631.8', '12.4', '2111.5', '-1632.5', '13.4', '0', 0),
(3, '1949.5', '-1574.3', '12.6', '1950.1', '-1574.9', '13.7', '44', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `factionvehicles`
--

CREATE TABLE `factionvehicles` (
  `ID` int(11) NOT NULL,
  `Owner` mediumint(5) NOT NULL,
  `VehID` smallint(3) NOT NULL,
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `RotX` varchar(20) NOT NULL,
  `RotY` varchar(20) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Fuel` smallint(3) NOT NULL DEFAULT '100',
  `Plate` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `factionvehicles`
--

INSERT INTO `factionvehicles` (`ID`, `Owner`, `VehID`, `SpawnX`, `SpawnY`, `SpawnZ`, `RotX`, `RotY`, `RotZ`, `Fuel`, `Plate`) VALUES
(1, 1, 597, '1558.9', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 1'),
(2, 1, 597, '1563.1', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 2'),
(3, 1, 597, '1566.5', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 3'),
(4, 1, 597, '1570.3', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 4'),
(5, 1, 597, '1574.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 5'),
(6, 1, 597, '1578.5', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 6'),
(7, 1, 597, '1583.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 7'),
(8, 1, 597, '1587.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 8'),
(9, 1, 597, '1591.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 9'),
(10, 1, 597, '1595.4', '-1710.6', '5.7', '0', '0', '0', 100, 'SAPD 10'),
(11, 1, 427, '1538.9', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 11'),
(12, 1, 427, '1534.6', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 12'),
(13, 1, 427, '1530.6', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 13'),
(14, 1, 427, '1526.6', '-1645.3', '6.0', '0', '0', '180', 100, 'SAPD 14'),
(15, 1, 601, '1545.5', '-1651', '5.6', '0', '0', '90', 100, 'SAPD 15'),
(16, 1, 601, '1545.5', '-1655.1', '5.6', '0', '0', '90', 100, 'SAPD 16'),
(17, 1, 601, '1545.5', '-1659.1', '5.6', '0', '0', '90', 100, 'SAPD 17'),
(18, 1, 598, '1601.8', '-1704.0', '5.7', '0', '0', '90', 100, 'SAPD 18'),
(19, 1, 598, '1601.8', '-1700.0', '5.7', '0', '0', '90', 100, 'SAPD 19'),
(20, 1, 598, '1601.8', '-1696.0', '5.7', '0', '0', '90', 100, 'SAPD 20'),
(21, 1, 598, '1601.8', '-1692.0', '5.7', '0', '0', '90', 100, 'SAPD 21'),
(22, 1, 598, '1601.8', '-1688.0', '5.7', '0', '0', '90', 100, 'SAPD 22'),
(23, 1, 598, '1601.8', '-1684.0', '5.7', '0', '0', '90', 100, 'SAPD 23'),
(24, 1, 497, '1562.3', '-1647.9', '28.5', '0', '0', '90', 100, 'SAPD 24'),
(25, 1, 497, '1562.3', '-1660.0', '28.5', '0', '0', '90', 100, 'SAPD 25'),
(26, 1, 497, '1562.299805', '-1691.194336', '28.588392', '0.219727', '359.785767', '89.923096', 100, 'SAPD 26'),
(27, 1, 497, '1562.3', '-1703.3', '28.5', '0', '0', '90', 100, 'SAPD 27'),
(50, 2, 490, '1278.1', '-1797.5', '13.5', '0', '0', '90', 100, 'FBI 1'),
(51, 2, 490, '1278.1', '-1802.5', '13.5', '0', '0', '90', 100, 'FBI 2'),
(52, 2, 490, '1278.1', '-1807.5', '13.5', '0', '0', '90', 100, 'FBI 3'),
(53, 2, 490, '1278.1', '-1812.5', '13.5', '0', '0', '90', 100, 'FBI 4'),
(54, 2, 490, '1278.1', '-1817.5', '13.5', '0', '0', '90', 100, 'FBI 5'),
(55, 2, 528, '1278.3', '-1822.5', '13.4', '0', '0', '90', 100, 'FBI 7'),
(56, 2, 528, '1278.3', '-1827.5', '13.4', '0', '0', '90', 100, 'FBI 8'),
(57, 2, 528, '1278.3', '-1832.5', '13.4', '0', '0', '90', 100, 'FBI 9'),
(58, 2, 597, '1238.538086', '-1814.357422', '13.196437', '359.566040', '0.027466', '239.425049', 100, 'FBI 10'),
(59, 2, 597, '1238.495117', '-1818.934570', '13.189699', '359.560547', '0.021973', '237.238770', 100, 'FBI 11'),
(60, 2, 597, '1238.425781', '-1823.589844', '13.212281', '359.653931', '0.021973', '236.925659', 100, 'FBI 12'),
(61, 2, 601, '1261.5', '-1795.3', '13', '0', '0', '180', 100, 'FBI 13'),
(62, 2, 601, '1266.5', '-1795.3', '13', '0', '0', '180', 100, 'FBI 14'),
(63, 2, 601, '1271.3', '-1795.3', '13', '0', '0', '180', 100, 'FBI 15'),
(64, 2, 497, '1264.6', '-1777.5', '33.7', '0', '0', '180', 100, 'FBI 16'),
(65, 2, 497, '1252.2', '-1777.5', '33.7', '0', '0', '180', 100, 'FBI 17'),
(66, 2, 497, '1228.8', '-1800.1', '33.7', '0', '0', '180', 100, 'FBI 18'),
(76, 2, 497, '1215.2', '-1800.1', '33.7', '0', '0', '180', 100, 'FBI 19');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gangdealercars`
--

CREATE TABLE `gangdealercars` (
  `ID` mediumint(5) NOT NULL,
  `VehID` mediumint(5) NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `gangdealercars`
--

INSERT INTO `gangdealercars` (`ID`, `VehID`, `Price`) VALUES
(410, 410, 23000),
(411, 411, 250000),
(445, 445, 39000),
(492, 492, 37200),
(496, 496, 42000),
(517, 517, 55000),
(549, 549, 17500),
(585, 585, 19600);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `globalcounter`
--

CREATE TABLE `globalcounter` (
  `UID` int(70) NOT NULL DEFAULT '1',
  `VID` int(70) NOT NULL DEFAULT '1',
  `FVID` int(70) NOT NULL DEFAULT '1',
  `PID` int(70) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `globalcounter`
--

INSERT INTO `globalcounter` (`UID`, `VID`, `FVID`, `PID`) VALUES
(1, 1, 180, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(35) NOT NULL,
  `Price` int(11) NOT NULL,
  `Cash` int(50) NOT NULL,
  `Rent` mediumint(5) NOT NULL DEFAULT '0',
  `State` varchar(10) NOT NULL DEFAULT 'false',
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `Interior` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `houses`
--

INSERT INTO `houses` (`ID`, `Owner`, `Price`, `Cash`, `Rent`, `State`, `SpawnX`, `SpawnY`, `SpawnZ`, `Interior`) VALUES
(1, 'none', 45000, 0, 0, 'false', '1854.025391', '-1914.417969', '15.256798', 1),
(2, 'none', 45000, 0, 0, 'false', '1872.220703', '-1911.958008', '15.256798', 1),
(3, 'none', 45000, 0, 0, 'false', '1891.909180', '-1914.589844', '15.256798', 1),
(4, 'none', 45000, 0, 0, 'false', '1913.461914', '-1911.988281', '15.256798', 1),
(5, 'none', 45000, 0, 0, 'false', '1938.510742', '-1911.331055', '15.256798', 1),
(6, 'none', 5000000, 0, 0, 'false', '1298.502930', '-797.986328', '84.140625', 31),
(7, 'none', 35000, 0, 0, 'false', '1245.399414', '-902.840820', '42.882812', 1),
(8, 'none', 35000, 0, 0, 'false', '1252.887695', '-901.855469', '42.882812', 1),
(9, 'none', 35000, 0, 0, 'false', '1253.716797', '-908.135742', '42.882812', 1),
(10, 'none', 35000, 0, 0, 'false', '1246.209961', '-908.989258', '42.882812', 1),
(11, 'none', 35000, 0, 0, 'false', '1252.893555', '-901.881836', '46.593887', 1),
(12, 'none', 35000, 0, 0, 'false', '1245.394531', '-902.796875', '46.593887', 1),
(13, 'none', 35000, 0, 0, 'false', '1253.708984', '-908.082031', '46.601562', 1),
(14, 'none', 35000, 0, 0, 'false', '1246.216797', '-909.045898', '46.601562', 1),
(15, 'none', 35000, 0, 0, 'false', '1283.528320', '-897.813477', '42.875343', 1),
(16, 'none', 35000, 0, 0, 'false', '1291.021484', '-896.879883', '42.882812', 1),
(17, 'none', 35000, 0, 0, 'false', '1284.338867', '-903.967773', '42.882812', 1),
(18, 'none', 35000, 0, 0, 'false', '1291.841797', '-903.071289', '42.882812', 1),
(19, 'none', 35000, 0, 0, 'false', '1284.342773', '-903.990234', '46.632812', 1),
(20, 'none', 35000, 0, 0, 'false', '1291.840820', '-903.067383', '46.632812', 1),
(21, 'none', 35000, 0, 0, 'false', '1283.533203', '-897.843750', '46.625137', 1),
(22, 'none', 35000, 0, 0, 'false', '1291.028320', '-896.905273', '46.625137', 1),
(23, 'none', 35000, 0, 0, 'false', '1242.126953', '-878.276367', '46.640625', 1),
(24, 'none', 35000, 0, 0, 'false', '1249.612305', '-877.328125', '46.640625', 1),
(25, 'none', 35000, 0, 0, 'false', '1241.305664', '-872.063477', '46.632950', 1),
(26, 'none', 35000, 0, 0, 'false', '1248.801758', '-871.155273', '46.632950', 1),
(27, 'none', 35000, 0, 0, 'false', '1248.804688', '-871.174805', '42.882812', 1),
(28, 'none', 35000, 0, 0, 'false', '1241.307617', '-872.084961', '42.882812', 1),
(29, 'none', 35000, 0, 0, 'false', '1249.619141', '-877.364258', '42.882812', 1),
(30, 'none', 35000, 0, 0, 'false', '1242.125977', '-878.310547', '42.875343', 1),
(31, 'none', 95000, 0, 0, 'false', '1325.944336', '-1066.454102', '31.554688', 6),
(32, 'none', 95000, 0, 0, 'false', '1326.261719', '-1091.885742', '27.976562', 6),
(33, 'none', 95000, 0, 0, 'false', '1285.253906', '-1066.021484', '31.671875', 6),
(34, 'none', 95000, 0, 0, 'false', '1285.266602', '-1091.430664', '28.257812', 6),
(35, 'none', 95000, 0, 0, 'false', '1241.946289', '-1075.252930', '31.554688', 6),
(36, 'none', 95000, 0, 0, 'false', '1242.262695', '-1100.715820', '27.976562', 6),
(37, 'none', 35000, 0, 0, 'false', '1227.242188', '-1017.130859', '32.601562', 1),
(38, 'none', 35000, 0, 0, 'false', '1234.738281', '-1016.179688', '32.606651', 1),
(39, 'none', 35000, 0, 0, 'false', '1226.428711', '-1010.950195', '32.601562', 1),
(40, 'none', 35000, 0, 0, 'false', '1233.924805', '-1010.004883', '32.601562', 1),
(41, 'none', 35000, 0, 0, 'false', '1233.920898', '-1010.002930', '36.328262', 1),
(42, 'none', 35000, 0, 0, 'false', '1226.425781', '-1010.897461', '36.328262', 1),
(43, 'none', 35000, 0, 0, 'false', '1234.732422', '-1016.166016', '36.335938', 1),
(44, 'none', 35000, 0, 0, 'false', '1227.238281', '-1017.079102', '36.335938', 1),
(45, 'none', 35000, 0, 0, 'false', '1196.500977', '-1017.117188', '32.546875', 1),
(46, 'none', 35000, 0, 0, 'false', '1189.011719', '-1018.085938', '32.546875', 1),
(47, 'none', 35000, 0, 0, 'false', '1188.185547', '-1011.841797', '32.546875', 1),
(48, 'none', 35000, 0, 0, 'false', '1195.679688', '-1010.885742', '32.553154', 1),
(49, 'none', 35000, 0, 0, 'false', '1195.683594', '-1010.928711', '36.226700', 1),
(50, 'none', 35000, 0, 0, 'false', '1188.185547', '-1011.836914', '36.226700', 1),
(51, 'none', 35000, 0, 0, 'false', '1196.490234', '-1017.041016', '36.234375', 1),
(52, 'none', 35000, 0, 0, 'false', '1189', '-1018', '36.234375', 1),
(53, 'none', 115000, 0, 0, 'false', '1127.984375', '-1021.171875', '34.992188', 6),
(54, 'none', 115000, 0, 0, 'false', '1118.087891', '-1021.341797', '34.992188', 6),
(55, 'none', 115000, 0, 0, 'false', '1050.982422', '-1059.290039', '34.796646', 6),
(56, 'none', 115000, 0, 0, 'false', '993.773438', '-1059.030273', '33.699501', 6),
(57, 'none', 95000, 0, 0, 'false', '1183.469727', '-1074.807617', '31.671875', 6),
(58, 'none', 95000, 0, 0, 'false', '1183.476562', '-1100.200195', '28.257812', 6),
(59, 'none', 95000, 0, 0, 'false', '1141.808594', '-1068.689453', '31.765625', 6),
(60, 'none', 135000, 0, 0, 'false', '827.801758', '-857.987305', '70.330811', 5),
(61, 'none', 165000, 0, 0, 'false', '1034.747070', '-813.208984', '101.851562', 5),
(62, 'none', 900000, 0, 0, 'false', '977.412109', '-771.480469', '112.202629', 5),
(63, 'none', 4200000, 0, 0, 'false', '1332.204102', '-633.168945', '109.134903', 31);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inventory`
--

CREATE TABLE `inventory` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Apple` int(11) NOT NULL DEFAULT '0',
  `Burger` int(11) NOT NULL DEFAULT '0',
  `Pizza` int(11) NOT NULL DEFAULT '0',
  `Candycane` int(11) NOT NULL DEFAULT '0',
  `Cola` int(11) NOT NULL DEFAULT '0',
  `IDcard` mediumint(5) NOT NULL DEFAULT '0',
  `ChestWood` int(11) NOT NULL DEFAULT '0',
  `ChestIron` int(11) NOT NULL DEFAULT '0',
  `TicketBronze` int(11) NOT NULL DEFAULT '0',
  `TicketSilver` int(11) NOT NULL DEFAULT '0',
  `TicketGold` int(11) NOT NULL DEFAULT '0',
  `Repairkit` int(11) NOT NULL DEFAULT '0',
  `Cocaine` int(11) NOT NULL DEFAULT '0',
  `Weed` int(11) NOT NULL DEFAULT '0',
  `WeedSeeds` int(11) NOT NULL DEFAULT '0',
  `AppleSeeds` int(11) NOT NULL DEFAULT '0',
  `Cigarette` int(11) NOT NULL DEFAULT '0',
  `Mobilephone` mediumint(5) NOT NULL DEFAULT '0',
  `VehicleKey` int(11) NOT NULL DEFAULT '0',
  `Armor` int(11) NOT NULL DEFAULT '0',
  `Pickaxe` int(11) NOT NULL DEFAULT '0',
  `Moonstone` int(11) NOT NULL DEFAULT '0',
  `Present` int(11) NOT NULL DEFAULT '0',
  `Fishingrod` int(11) NOT NULL DEFAULT '0',
  `Fishinghook` int(11) NOT NULL DEFAULT '0',
  `Bait` int(11) NOT NULL DEFAULT '0',
  `Trout` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lotto`
--

CREATE TABLE `lotto` (
  `Username` varchar(50) NOT NULL,
  `Number1` mediumint(5) NOT NULL,
  `Number2` mediumint(5) NOT NULL,
  `Number3` mediumint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userbans`
--

CREATE TABLE `userbans` (
  `Username` varchar(35) NOT NULL,
  `Admin` varchar(35) NOT NULL,
  `Reason` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userdata`
--

CREATE TABLE `userdata` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Password` text NOT NULL,
  `Email` text NOT NULL,
  `RegisterDate` text NOT NULL,
  `LastLoginDate` text NOT NULL,
  `BirthDate` varchar(14) NOT NULL DEFAULT '0',
  `Gender` varchar(10) NOT NULL DEFAULT 'Male',
  `AdminLvL` int(11) NOT NULL DEFAULT '0',
  `Faction` int(11) NOT NULL DEFAULT '0',
  `Factionrank` int(11) NOT NULL DEFAULT '0',
  `Company` int(11) NOT NULL DEFAULT '0',
  `Companyrank` int(11) NOT NULL DEFAULT '0',
  `Money` int(50) NOT NULL DEFAULT '0',
  `Bankmoney` int(50) NOT NULL DEFAULT '0',
  `Jobmoney` int(50) NOT NULL DEFAULT '0',
  `Armor` mediumint(3) NOT NULL DEFAULT '0',
  `Health` mediumint(3) NOT NULL DEFAULT '100',
  `Job` varchar(30) NOT NULL DEFAULT 'none',
  `Hunger` mediumint(3) NOT NULL DEFAULT '100',
  `Urin` int(11) NOT NULL DEFAULT '0',
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `SpawnROT` varchar(20) NOT NULL,
  `SpawnINT` varchar(20) NOT NULL DEFAULT '0',
  `SpawnDIM` varchar(20) NOT NULL DEFAULT '0',
  `SkinID` int(11) NOT NULL DEFAULT '0',
  `Playtime` int(11) NOT NULL DEFAULT '0',
  `Mutedtime` int(11) NOT NULL DEFAULT '0',
  `Jailtime` int(11) NOT NULL DEFAULT '0',
  `Vehicleslots` int(11) NOT NULL DEFAULT '2',
  `Housekey` int(50) NOT NULL DEFAULT '0',
  `Task` smallint(2) NOT NULL DEFAULT '1',
  `Bankpin` int(11) NOT NULL DEFAULT '0',
  `Telenr` int(11) NOT NULL DEFAULT '0',
  `Wanteds` int(11) NOT NULL DEFAULT '0',
  `IntroCompleted` tinyint(1) NOT NULL DEFAULT '0',
  `CarLicense` mediumint(5) NOT NULL DEFAULT '0',
  `BikeLicense` mediumint(5) NOT NULL DEFAULT '0',
  `CarLicensePoints` int(11) NOT NULL DEFAULT '0',
  `BikeLicensePoints` int(11) NOT NULL DEFAULT '0',
  `GunLicense` mediumint(5) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userlevel`
--

CREATE TABLE `userlevel` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Joblevel` int(11) NOT NULL DEFAULT '0',
  `Jobexp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userlogout`
--

CREATE TABLE `userlogout` (
  `UID` int(50) NOT NULL,
  `Weapons` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userplants`
--

CREATE TABLE `userplants` (
  `ID` int(200) NOT NULL,
  `UID` int(70) NOT NULL,
  `Model` int(11) NOT NULL,
  `SpawnX` varchar(50) NOT NULL,
  `SpawnY` varchar(50) NOT NULL,
  `SpawnZ` varchar(50) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Time` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `usersettings`
--

CREATE TABLE `usersettings` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `PhoneModel` int(11) NOT NULL DEFAULT '1',
  `PhoneBackground` int(11) NOT NULL DEFAULT '1',
  `PhoneState` int(11) NOT NULL DEFAULT '1',
  `Autologin` mediumint(5) NOT NULL DEFAULT '0',
  `Radar` mediumint(5) NOT NULL DEFAULT '1',
  `Snowshader` mediumint(5) NOT NULL DEFAULT '1',
  `Blurshader` mediumint(5) NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userstats`
--

CREATE TABLE `userstats` (
  `UID` int(70) NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Kills` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `uservehicles`
--

CREATE TABLE `uservehicles` (
  `ID` int(70) NOT NULL,
  `UID` int(50) NOT NULL,
  `Owner` varchar(35) NOT NULL,
  `VehID` smallint(3) NOT NULL,
  `SpawnX` varchar(20) NOT NULL,
  `SpawnY` varchar(20) NOT NULL,
  `SpawnZ` varchar(20) NOT NULL,
  `RotX` varchar(20) NOT NULL,
  `RotY` varchar(20) NOT NULL,
  `RotZ` varchar(20) NOT NULL,
  `Tunings` varchar(300) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `Sportmotor` smallint(3) NOT NULL DEFAULT '0',
  `Lowering` smallint(3) NOT NULL DEFAULT '0',
  `Color` varchar(50) NOT NULL DEFAULT '0|0|0',
  `Slot` smallint(4) NOT NULL,
  `Totalloss` int(11) NOT NULL DEFAULT '0',
  `Health` int(11) NOT NULL DEFAULT '1000',
  `Fuel` smallint(3) NOT NULL,
  `Plate` varchar(15) NOT NULL,
  `Towed` int(11) NOT NULL DEFAULT '0',
  `Keys` varchar(50) NOT NULL DEFAULT '',
  `Forgivenkeys` int(11) NOT NULL DEFAULT '0',
  `Trunk` varchar(100) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `weaponbox`
--

CREATE TABLE `weaponbox` (
  `ID` int(50) NOT NULL,
  `UID` int(50) NOT NULL,
  `Weapon1` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu1` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon2` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu2` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon3` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu3` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon4` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu4` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon5` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu5` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon6` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu6` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon7` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu7` varchar(50) NOT NULL DEFAULT 'none',
  `Weapon8` varchar(50) NOT NULL DEFAULT 'none',
  `Ammu8` varchar(50) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `whitelist`
--

CREATE TABLE `whitelist` (
  `Username` varchar(50) NOT NULL,
  `Serial` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `changelogs`
--
ALTER TABLE `changelogs`
  ADD PRIMARY KEY (`SortID`);

--
-- Indizes für die Tabelle `companyvehicles`
--
ALTER TABLE `companyvehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `factiondepots`
--
ALTER TABLE `factiondepots`
  ADD PRIMARY KEY (`Faction`);

--
-- Indizes für die Tabelle `factiontags`
--
ALTER TABLE `factiontags`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `factionvehicles`
--
ALTER TABLE `factionvehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `gangdealercars`
--
ALTER TABLE `gangdealercars`
  ADD PRIMARY KEY (`VehID`);

--
-- Indizes für die Tabelle `globalcounter`
--
ALTER TABLE `globalcounter`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `lotto`
--
ALTER TABLE `lotto`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `userbans`
--
ALTER TABLE `userbans`
  ADD PRIMARY KEY (`Serial`);

--
-- Indizes für die Tabelle `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userlevel`
--
ALTER TABLE `userlevel`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userlogout`
--
ALTER TABLE `userlogout`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userplants`
--
ALTER TABLE `userplants`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `usersettings`
--
ALTER TABLE `usersettings`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `userstats`
--
ALTER TABLE `userstats`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `uservehicles`
--
ALTER TABLE `uservehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `weaponbox`
--
ALTER TABLE `weaponbox`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`Serial`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `factiontags`
--
ALTER TABLE `factiontags`
  MODIFY `ID` int(70) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT für Tabelle `factionvehicles`
--
ALTER TABLE `factionvehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;
--
-- AUTO_INCREMENT für Tabelle `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT für Tabelle `weaponbox`
--
ALTER TABLE `weaponbox`
  MODIFY `ID` int(50) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
