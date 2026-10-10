CREATE DATABASE  IF NOT EXISTS `gestioneaziendam.estetica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestioneaziendam.estetica`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: gestioneaziendam.estetica
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `associare`
--

DROP TABLE IF EXISTS `associare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `associare` (
  `macchinarioBase` varchar(30) NOT NULL,
  `macchinarioAccessorio` varchar(30) NOT NULL,
  PRIMARY KEY (`macchinarioBase`,`macchinarioAccessorio`),
  KEY `macchinarioAccessorio_idx` (`macchinarioAccessorio`),
  CONSTRAINT `macchinarioAccessorio` FOREIGN KEY (`macchinarioAccessorio`) REFERENCES `macchinario` (`codiceSeriale`) ON UPDATE CASCADE,
  CONSTRAINT `macchinarioBase` FOREIGN KEY (`macchinarioBase`) REFERENCES `macchinario` (`codiceSeriale`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `nome` varchar(50) NOT NULL,
  `tipoCategoria` enum('base','accessorio') NOT NULL,
  `destinazioneUso` varchar(20) NOT NULL,
  `Altezza` double DEFAULT NULL,
  `larghezza` double DEFAULT NULL,
  `lunghezza` double DEFAULT NULL,
  `numApplicazioni` int DEFAULT NULL,
  `tipoTrattamenti` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `CF` char(16) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `residenza` varchar(20) NOT NULL,
  `numCellulare` varchar(20) NOT NULL,
  `numTelefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `numAcquisti` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`CF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corriere`
--

DROP TABLE IF EXISTS `corriere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corriere` (
  `targa` char(7) NOT NULL,
  `società` varchar(45) NOT NULL,
  `dataPrimoImpiego` date NOT NULL,
  PRIMARY KEY (`targa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dirigere`
--

DROP TABLE IF EXISTS `dirigere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dirigere` (
  `numOreDedicate` int NOT NULL,
  `ingegnereDirigere` char(16) NOT NULL,
  `interventoDirigere` int NOT NULL,
  `macchinarioDirigere` varchar(30) NOT NULL,
  PRIMARY KEY (`ingegnereDirigere`,`interventoDirigere`,`macchinarioDirigere`),
  KEY `interventoDirigere_idx` (`interventoDirigere`),
  KEY `macchinarioDirigere_idx` (`macchinarioDirigere`),
  CONSTRAINT `ingegnereDirigere` FOREIGN KEY (`ingegnereDirigere`) REFERENCES `ingegnere` (`cf`),
  CONSTRAINT `interventoDirigere` FOREIGN KEY (`interventoDirigere`) REFERENCES `intervento` (`numProgressivoMacchinarioAssociato`),
  CONSTRAINT `macchinarioDirigere` FOREIGN KEY (`macchinarioDirigere`) REFERENCES `intervento` (`macchinarioIntervento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eseguire`
--

DROP TABLE IF EXISTS `eseguire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eseguire` (
  `operaioEseguire` char(16) NOT NULL,
  `progettoEseguire` int NOT NULL,
  PRIMARY KEY (`operaioEseguire`,`progettoEseguire`),
  KEY `progettoEseguire_idx` (`progettoEseguire`),
  CONSTRAINT `operaioEseguire` FOREIGN KEY (`operaioEseguire`) REFERENCES `operaio` (`cf`) ON UPDATE CASCADE,
  CONSTRAINT `progettoEseguire` FOREIGN KEY (`progettoEseguire`) REFERENCES `progetto` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingegnere`
--

DROP TABLE IF EXISTS `ingegnere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingegnere` (
  `cf` char(16) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cognome` varchar(45) NOT NULL,
  `numTelefono` varchar(20) DEFAULT NULL,
  `numCellulare` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `tipoContratto` enum('determinato','indeterminato','stagista','part-time','apprendistato') NOT NULL,
  `alboProfessionale` varchar(20) NOT NULL,
  `specializzazione` varchar(20) NOT NULL,
  `residenza` varchar(20) NOT NULL,
  PRIMARY KEY (`cf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intervento`
--

DROP TABLE IF EXISTS `intervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intervento` (
  `numProgressivoMacchinarioAssociato` int NOT NULL AUTO_INCREMENT,
  `dataCompletamento` date DEFAULT NULL,
  `dataInzio` date NOT NULL,
  `stato` enum('richiesto','valutato','lavorazione','verificato','completato') NOT NULL,
  `tipoIntervento` enum('manutenzione','sostituzione') NOT NULL,
  `ingegnereIntervento` char(16) DEFAULT NULL,
  `macchinarioIntervento` varchar(30) NOT NULL,
  PRIMARY KEY (`numProgressivoMacchinarioAssociato`),
  KEY `ing_idx` (`ingegnereIntervento`),
  KEY `macchinarioIntervento_idx` (`macchinarioIntervento`),
  CONSTRAINT `ing` FOREIGN KEY (`ingegnereIntervento`) REFERENCES `ingegnere` (`cf`) ON UPDATE CASCADE,
  CONSTRAINT `macchinarioIntervento` FOREIGN KEY (`macchinarioIntervento`) REFERENCES `macchinario` (`codiceSeriale`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `macchinario`
--

DROP TABLE IF EXISTS `macchinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `macchinario` (
  `codiceSeriale` varchar(30) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `prezzo` double NOT NULL,
  `numLotto` int NOT NULL,
  `progetto` int NOT NULL,
  `cliente` char(16) DEFAULT NULL,
  `categoria` varchar(50) NOT NULL,
  `dataAcquisto` date DEFAULT NULL,
  PRIMARY KEY (`codiceSeriale`),
  KEY `progetto_idx` (`progetto`),
  KEY `cliente_idx` (`cliente`),
  KEY `categoria_idx` (`categoria`),
  CONSTRAINT `categoria` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`nome`) ON UPDATE CASCADE,
  CONSTRAINT `cliente` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`CF`) ON UPDATE CASCADE,
  CONSTRAINT `progetto` FOREIGN KEY (`progetto`) REFERENCES `progetto` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operaio`
--

DROP TABLE IF EXISTS `operaio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operaio` (
  `cf` char(16) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `numCellulare` varchar(20) NOT NULL,
  `numTelefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `tipoContratto` enum('determinato','indeterminato','stagista','part-time','apprendistato') NOT NULL,
  `numOreManutenzione` int NOT NULL,
  `residenza` varchar(20) NOT NULL,
  PRIMARY KEY (`cf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `corriereOrdine` char(7) NOT NULL,
  `macchinarioOrdine` varchar(30) NOT NULL,
  PRIMARY KEY (`corriereOrdine`,`macchinarioOrdine`),
  KEY `macchinarioOrdine_idx` (`macchinarioOrdine`),
  CONSTRAINT `corriereOrdine` FOREIGN KEY (`corriereOrdine`) REFERENCES `corriere` (`targa`) ON UPDATE CASCADE,
  CONSTRAINT `macchinarioOrdine` FOREIGN KEY (`macchinarioOrdine`) REFERENCES `macchinario` (`codiceSeriale`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partecipare`
--

DROP TABLE IF EXISTS `partecipare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partecipare` (
  `numOreDedicate` double NOT NULL,
  `macchinarioPartecipare` varchar(30) NOT NULL,
  `operaioPartecipare` char(16) NOT NULL,
  `interventoPartecipare` int NOT NULL,
  PRIMARY KEY (`macchinarioPartecipare`,`operaioPartecipare`,`interventoPartecipare`),
  KEY `operaioPartecipare_idx` (`operaioPartecipare`),
  KEY `interventoPartecipare_idx` (`interventoPartecipare`),
  CONSTRAINT `interventoPartecipare` FOREIGN KEY (`interventoPartecipare`) REFERENCES `intervento` (`numProgressivoMacchinarioAssociato`) ON UPDATE CASCADE,
  CONSTRAINT `macchinarioPartecipare` FOREIGN KEY (`macchinarioPartecipare`) REFERENCES `intervento` (`macchinarioIntervento`) ON UPDATE CASCADE,
  CONSTRAINT `operaioPartecipare` FOREIGN KEY (`operaioPartecipare`) REFERENCES `operaio` (`cf`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `progetto`
--

DROP TABLE IF EXISTS `progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progetto` (
  `ID` int NOT NULL,
  `tipo` enum('prototipale','pilota','collaudato','commercializzato') NOT NULL,
  `Ingegnere` char(16) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `cf_idx` (`Ingegnere`),
  CONSTRAINT `Ingegnere` FOREIGN KEY (`Ingegnere`) REFERENCES `ingegnere` (`cf`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-07 16:28:09
