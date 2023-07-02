CREATE DATABASE  IF NOT EXISTS `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `fecCreacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Jose Feliciano','2023-07-01 13:07:30',_binary '\0'),(2,'Ana Marquez','2023-07-01 13:07:30',_binary ''),(3,'Juan Osorio222333','2023-07-01 17:14:00',_binary ''),(4,'Maria Perez Lepoldo','2023-07-01 17:48:23',_binary ''),(5,'Juana Perez Lucas','2023-07-01 17:53:28',_binary ''),(6,'lucas yuman','2023-07-01 17:54:57',_binary ''),(7,'yuman jije','2023-07-01 17:55:34',_binary ''),(8,'maylin fuentes2222','2023-07-01 17:56:07',_binary ''),(9,'ale lima','2023-07-01 17:57:13',_binary ''),(10,'ale perez','2023-07-01 18:19:02',_binary ''),(12,'ale perez2','2023-07-01 18:19:50',_binary ''),(17,'chicharron perez','2023-07-01 20:06:24',_binary ''),(19,'prueba','2023-07-01 20:06:58',_binary ''),(27,'dddd','2023-07-01 20:34:00',_binary '\0'),(30,'juancho pansa','2023-07-01 21:30:27',_binary '\0'),(32,'maiden luna','2023-07-01 22:03:31',_binary ''),(33,'prueba 1 mixco','2023-07-01 22:04:55',_binary ''),(34,'prueba prueba','2023-07-02 16:55:04',_binary '');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editorial`
--

DROP TABLE IF EXISTS `editorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editorial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(450) DEFAULT NULL,
  `fecCreacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editorial`
--

LOCK TABLES `editorial` WRITE;
/*!40000 ALTER TABLE `editorial` DISABLE KEYS */;
INSERT INTO `editorial` VALUES (1,'Santillana','2023-07-01 14:51:25',_binary ''),(2,'Catafixia','2023-07-01 14:51:55',_binary ''),(3,'Smurfs','2023-07-01 14:52:09',_binary '');
/*!40000 ALTER TABLE `editorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libro` (
  `isbn` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(450) DEFAULT NULL,
  `editorial` int NOT NULL,
  `anioEdicion` int DEFAULT NULL,
  `autor` int NOT NULL,
  `precioPrestamo` decimal(6,2) DEFAULT NULL,
  `fecCreacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` bit(1) DEFAULT b'1',
  PRIMARY KEY (`isbn`),
  UNIQUE KEY `titulo_UNIQUE` (`titulo`),
  KEY `fk_autor_idx` (`autor`),
  KEY `fk_editorial_idx` (`editorial`),
  CONSTRAINT `fk_autor` FOREIGN KEY (`autor`) REFERENCES `autor` (`id`),
  CONSTRAINT `fk_editorial` FOREIGN KEY (`editorial`) REFERENCES `editorial` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (1,'Matematica 1',1,2023,1,230.90,'2023-07-01 14:52:49',_binary '\0'),(2,'Ciencias Naturales',2,2023,1,90.89,'2023-07-01 15:32:13',_binary '\0'),(3,'Ingles 1',1,2022,2,88.34,'2023-07-01 15:32:43',_binary ''),(4,'Matematica 12',1,2023,1,500.00,'2023-07-01 15:34:00',_binary '\0'),(7,'Prueba eshta',2,2010,2,45.55,'2023-07-01 16:19:26',_binary '\0'),(8,'ASDASDASDASD',3,233,30,89.89,'2023-07-02 13:46:33',_binary '\0'),(9,'maiden loca',2,2011,6,100.00,'2023-07-02 14:17:58',_binary ''),(10,'tarde de lluvia',3,2000,34,75.00,'2023-07-02 16:55:46',_binary '');
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `socio` int DEFAULT NULL,
  `libro` int DEFAULT NULL,
  `fecPrestamo` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecDevolucion` datetime DEFAULT NULL,
  `totalPrestamo` decimal(6,2) DEFAULT NULL,
  `estado` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `fk_prestamo_libro_idx` (`libro`),
  KEY `fk_prestamo_socio_idx` (`socio`),
  CONSTRAINT `fk_prestamo_libro` FOREIGN KEY (`libro`) REFERENCES `libro` (`isbn`),
  CONSTRAINT `fk_prestamo_socio` FOREIGN KEY (`socio`) REFERENCES `socio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio`
--

DROP TABLE IF EXISTS `socio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `fecCreacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo_UNIQUE` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socio`
--

LOCK TABLES `socio` WRITE;
/*!40000 ALTER TABLE `socio` DISABLE KEYS */;
/*!40000 ALTER TABLE `socio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'biblioteca'
--

--
-- Dumping routines for database 'biblioteca'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-02 17:29:32
