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
-- Dumping data for table `associare`
--

LOCK TABLES `associare` WRITE;
/*!40000 ALTER TABLE `associare` DISABLE KEYS */;
INSERT INTO `associare` VALUES ('W2ZutakSZdME3V5Xm3SBcD7ssyeVSh','qah6PrhwwQd3WaHdVTz9apwbTJUPCj'),('UorVTafrh3tVFS83Gcb7FAX5CbouAi','qdNmMVaVUb7kKGLMmU46JvqQrZ6xdu'),('yxTUY8kJNCKSV2wv8XPfRQficPSTSC','qdNmMVaVUb7kKGLMmU46JvqQrZ6xdu');
/*!40000 ALTER TABLE `associare` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES ('CrioLiposuzione','base','Professionale',44.5,19.5,33.5,NULL,'Trattamenti per grasso eccessivo'),('Depilatore Luce Pulsata','base','Medico',12.3,66.7,65.3,NULL,'Rimozione peli indesiderati'),('Elettrostimolatore','base','Professionale',22.5,22.7,23.4,NULL,'Fisioterapia'),('FibroBlast','base','Medico',33.5,66.7,22.4,NULL,'Rimozione macchie e cicatrici'),('Liposuzione','base','Professionale',33.4,33.2,71.3,NULL,'Trattamenti per grasso eccessivo'),('Pistola Lipo Laser','accessorio','Medico',NULL,NULL,NULL,3,''),('Pressoterapia','base','Privato',54.6,88.7,55.7,NULL,'Controllo sanguigno'),('Spatola Peeling','accessorio','Privato',NULL,NULL,NULL,1,'');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('HGVLMF64M07I431L','Franco','Nardi','Caserta','3314233444','817688184','fnardi@email.com',1),('MWFLYJ54H26E125L','Francesco','Mille','Roma','5715900881','1550368764','fmille@email.com',1),('RZZMGH62B67G359N','Margherita','Razzetti','Rovigo','5561462322',NULL,'mrazzetti@email.com',1),('SDBQVP71P64A709A','Laura','Marca','Milano','8948037158','3315517309','lmarca@email.com',1),('TZHBNL50R70Z320W','Maria','Caligola','Napoli','5922898246','8522347200','mcaligola@email.com',2);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `corriere`
--

LOCK TABLES `corriere` WRITE;
/*!40000 ALTER TABLE `corriere` DISABLE KEYS */;
INSERT INTO `corriere` VALUES ('AU867LO','Poste Italiane','2007-03-07'),('BU386KW','Bartolini','2002-03-00'),('CD289PX','GLS','1995-11-03'),('GA129KM','UPS','1996-04-05');
/*!40000 ALTER TABLE `corriere` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `dirigere`
--

LOCK TABLES `dirigere` WRITE;
/*!40000 ALTER TABLE `dirigere` DISABLE KEYS */;
INSERT INTO `dirigere` VALUES (520,'GGINLK83D50C094T',3,'qsw6jaA4Rjqo5TNwk54bt42XsffQRb'),(480,'GGINLK83D50C094T',5,'W2ZutakSZdME3V5Xm3SBcD7ssyeVSh'),(240,'LZZLNZ39C11B684H',4,'UorVTafrh3tVFS83Gcb7FAX5CbouAi'),(480,'LZZLNZ39C11B684H',6,'yxTUY8kJNCKSV2wv8XPfRQficPSTSC'),(240,'NGRDDG37D25B733K',1,'D7GpWY3mLGVwpkLeeRrFmwDeeks5s2'),(480,'NGRDDG37D25B733K',2,'qah6PrhwwQd3WaHdVTz9apwbTJUPCj');
/*!40000 ALTER TABLE `dirigere` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `eseguire`
--

LOCK TABLES `eseguire` WRITE;
/*!40000 ALTER TABLE `eseguire` DISABLE KEYS */;
INSERT INTO `eseguire` VALUES ('GRGNZT40L04C769O',1),('GRNCLN33E64H097J',1),('HDCVDG87E56C960O',1),('NZRRNN06D26A407E',2),('PLLLFR19E08F648J',2),('GRGNZT40L04C769O',3),('GRNCLN33E64H097J',3),('HDCVDG87E56C960O',4),('PLLLFR19E08F648J',4),('GRGNZT40L04C769O',5),('HDCVDG87E56C960O',5),('GRGNZT40L04C769O',6),('PLLLFR19E08F648J',6),('GRNCLN33E64H097J',7),('HDCVDG87E56C960O',7),('GRGNZT40L04C769O',8),('PLLLFR19E08F648J',8);
/*!40000 ALTER TABLE `eseguire` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `ingegnere`
--

LOCK TABLES `ingegnere` WRITE;
/*!40000 ALTER TABLE `ingegnere` DISABLE KEYS */;
INSERT INTO `ingegnere` VALUES ('GGINLK83D50C094T','Angelica','Gigo','9948993334','4068456920','agigo@email.com','determinato','Ingegneri di Milano','Gestionale','Milano'),('LZZLNZ39C11B684H','Daniele','Luzzu','4358883934','8224494682','dluzzu@email.com','indeterminato','Ingegneri di Salerno','Industriale','Fisciano'),('NGRDDG37D25B733K','Giuseppe','Ingardo','9653782965','9625031054','gingardo@email.com','determinato','Ingegneri di Pavia','Meccatronica','Pavia');
/*!40000 ALTER TABLE `ingegnere` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `intervento`
--

LOCK TABLES `intervento` WRITE;
/*!40000 ALTER TABLE `intervento` DISABLE KEYS */;
INSERT INTO `intervento` VALUES (1,'2020-04-12','2020-02-22','completato','manutenzione',NULL,'D7GpWY3mLGVwpkLeeRrFmwDeeks5s2'),(2,NULL,'2018-12-01','lavorazione','sostituzione','LZZLNZ39C11B684H','qah6PrhwwQd3WaHdVTz9apwbTJUPCj'),(3,NULL,'2021-04-02','verificato','manutenzione',NULL,'qsw6jaA4Rjqo5TNwk54bt42XsffQRb'),(4,NULL,'2021-01-01','valutato','manutenzione',NULL,'UorVTafrh3tVFS83Gcb7FAX5CbouAi'),(5,NULL,'2021-10-22','richiesto','manutenzione',NULL,'W2ZutakSZdME3V5Xm3SBcD7ssyeVSh'),(6,'2019-05-23','2019-03-01','completato','sostituzione','NGRDDG37D25B733K','yxTUY8kJNCKSV2wv8XPfRQficPSTSC');
/*!40000 ALTER TABLE `intervento` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `macchinario`
--

LOCK TABLES `macchinario` WRITE;
/*!40000 ALTER TABLE `macchinario` DISABLE KEYS */;
INSERT INTO `macchinario` VALUES ('D7GpWY3mLGVwpkLeeRrFmwDeeks5s2','Macchinario trattamenti pressione sanguigna.',1324,1,4,'SDBQVP71P64A709A','Pressoterapia','2015-08-01'),('oLPWysaHnY9iwU7umjyL4mbDsKWU2v','Macchinario multiuso: lesioni vascolari e rimozione macchie.',1230,33,2,NULL,'FibroBlast',NULL),('qah6PrhwwQd3WaHdVTz9apwbTJUPCj','Accessorio per trattamento sebo del viso.',320,4,6,NULL,'Spatola Peeling',NULL),('qdNmMVaVUb7kKGLMmU46JvqQrZ6xdu','Accessorio per trattamenti obesità.',700,5,7,'MWFLYJ54H26E125L','Pistola Lipo Laser','2018-10-22'),('qsw6jaA4Rjqo5TNwk54bt42XsffQRb','Macchinario professionale per i trattamenti di elettrostimolazione.',1000,12,1,'HGVLMF64M07I431L','Elettrostimolatore','2014-03-09'),('UorVTafrh3tVFS83Gcb7FAX5CbouAi','Macchinario di liposuzione.',2000,35,5,'TZHBNL50R70Z320W','Liposuzione','2016-07-06'),('W2ZutakSZdME3V5Xm3SBcD7ssyeVSh','Macchinario laser per depilazione definitiva.',1450,2,3,'RZZMGH62B67G359N','Depilatore Luce Pulsata','2015-02-22'),('yxTUY8kJNCKSV2wv8XPfRQficPSTSC','Macchinario per CrioLiposuzione.',1890,21,8,'TZHBNL50R70Z320W','CrioLiposuzione','2018-07-31');
/*!40000 ALTER TABLE `macchinario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `operaio`
--

LOCK TABLES `operaio` WRITE;
/*!40000 ALTER TABLE `operaio` DISABLE KEYS */;
INSERT INTO `operaio` VALUES ('GRGNZT40L04C769O','Gariglio','Nunziato','5994866533','8111758515','gnunziato@email.com','part-time',588,'Ischia'),('GRNCLN33E64H097J','Carolina','Adele','2604928923','4079433337','cadele@email.com','indeterminato',608,'Avellino'),('HDCVDG87E56C960O','Giuseppina','Vanda','9467904634','3212774304','gvanda@email.com','stagista',278,'Catanzaro'),('NZRRNN06D26A407E','Andrea','Urbano','2323794698','4079433330','aurbano@email.com','determinato',660,'Nuoro'),('PLLLFR19E08F648J','Luigi','Pelletta','9314533755','7074614364','lpelletta@email.com','determinato',1136,'Fisciano');
/*!40000 ALTER TABLE `operaio` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES ('AU867LO','D7GpWY3mLGVwpkLeeRrFmwDeeks5s2'),('BU386KW','qah6PrhwwQd3WaHdVTz9apwbTJUPCj'),('CD289PX','qsw6jaA4Rjqo5TNwk54bt42XsffQRb'),('GA129KM','UorVTafrh3tVFS83Gcb7FAX5CbouAi'),('CD289PX','W2ZutakSZdME3V5Xm3SBcD7ssyeVSh'),('AU867LO','yxTUY8kJNCKSV2wv8XPfRQficPSTSC');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `partecipare`
--

LOCK TABLES `partecipare` WRITE;
/*!40000 ALTER TABLE `partecipare` DISABLE KEYS */;
INSERT INTO `partecipare` VALUES (168,'D7GpWY3mLGVwpkLeeRrFmwDeeks5s2','GRGNZT40L04C769O',1),(240,'D7GpWY3mLGVwpkLeeRrFmwDeeks5s2','GRNCLN33E64H097J',1),(240,'qah6PrhwwQd3WaHdVTz9apwbTJUPCj','GRGNZT40L04C769O',2),(480,'qah6PrhwwQd3WaHdVTz9apwbTJUPCj','NZRRNN06D26A407E',2),(656,'qah6PrhwwQd3WaHdVTz9apwbTJUPCj','PLLLFR19E08F648J',2),(24,'qsw6jaA4Rjqo5TNwk54bt42XsffQRb','HDCVDG87E56C960O',3),(60,'qsw6jaA4Rjqo5TNwk54bt42XsffQRb','NZRRNN06D26A407E',3),(120,'UorVTafrh3tVFS83Gcb7FAX5CbouAi','NZRRNN06D26A407E',4),(480,'UorVTafrh3tVFS83Gcb7FAX5CbouAi','PLLLFR19E08F648J',4),(120,'W2ZutakSZdME3V5Xm3SBcD7ssyeVSh','GRGNZT40L04C769O',5),(20,'W2ZutakSZdME3V5Xm3SBcD7ssyeVSh','HDCVDG87E56C960O',5),(60,'yxTUY8kJNCKSV2wv8XPfRQficPSTSC','GRGNZT40L04C769O',6),(368,'yxTUY8kJNCKSV2wv8XPfRQficPSTSC','GRNCLN33E64H097J',6),(234,'yxTUY8kJNCKSV2wv8XPfRQficPSTSC','HDCVDG87E56C960O',6);
/*!40000 ALTER TABLE `partecipare` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Dumping data for table `progetto`
--

LOCK TABLES `progetto` WRITE;
/*!40000 ALTER TABLE `progetto` DISABLE KEYS */;
INSERT INTO `progetto` VALUES (1,'prototipale','GGINLK83D50C094T'),(2,'pilota','GGINLK83D50C094T'),(3,'prototipale','LZZLNZ39C11B684H'),(4,'collaudato','NGRDDG37D25B733K'),(5,'commercializzato','LZZLNZ39C11B684H'),(6,'collaudato','LZZLNZ39C11B684H'),(7,'pilota','NGRDDG37D25B733K'),(8,'collaudato','GGINLK83D50C094T');
/*!40000 ALTER TABLE `progetto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-07 16:28:26
