-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: wk
-- ------------------------------------------------------
-- Server version	5.6.50-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `cd_cliente` int(11) NOT NULL,
  `ds_nome` varchar(100) NOT NULL,
  `ds_cidade` varchar(100) NOT NULL,
  `cd_uf` char(2) NOT NULL,
  PRIMARY KEY (`cd_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Maria Silva','Curitiba','PR'),(2,'João Souza','Londrina','PR'),(3,'Ana Pereira','Maringá','PR'),(4,'José Oliveira','Ponta Grossa','PR'),(5,'Antônio Lima','Cascavel','PR'),(6,'Francisca Rodrigues','São José dos Pinhais','PR'),(7,'Carlos Alves','Foz do Iguaçu','PR'),(8,'Paulo Ferreira','Colombo','PR'),(9,'Pedro Santos','Guarapuava','PR'),(10,'Lucas Gonçalves','Paranaguá','PR'),(11,'Marcos Gomes','Florianópolis','SC'),(12,'Rafael Costa','Joinville','SC'),(13,'Fernanda Ribeiro','Blumenau','SC'),(14,'Sandra Martins','São José','SC'),(15,'Daniel Carvalho','Chapecó','SC'),(16,'Leonardo Almeida','Criciúma','SC'),(17,'Beatriz Pinto','Itajaí','SC'),(18,'Mariana Araújo','Jaraguá do Sul','SC'),(19,'Ricardo Melo','Palhoça','SC'),(20,'Tiago Barbosa','Lages','SC'),(21,'Camila Castro','São Paulo','SP'),(22,'Matheus Dias','Guarulhos','SP'),(23,'Gabriel Fernandes','Campinas','SP'),(24,'Felipe Azevedo','São Bernardo do Campo','SP'),(25,'Julia Teixeira','Santo André','SP'),(26,'Eduardo Correia','Osasco','SP'),(27,'Gustavo Moreira','São José dos Campos','SP'),(28,'Bruno Mendes','Ribeirão Preto','SP');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `nr_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `dt_emissao` datetime NOT NULL,
  `cd_cliente` int(11) NOT NULL,
  `vl_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`nr_pedido`),
  KEY `cd_cliente` (`cd_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cd_cliente`) REFERENCES `clientes` (`cd_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_produtos`
--

DROP TABLE IF EXISTS `pedidos_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_produtos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nr_pedido` int(11) NOT NULL,
  `cd_produto` int(11) NOT NULL,
  `nr_quantidade` int(11) NOT NULL,
  `vl_unitario` decimal(10,2) NOT NULL,
  `vl_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nr_pedido` (`nr_pedido`),
  KEY `cd_produto` (`cd_produto`),
  CONSTRAINT `pedidos_produtos_ibfk_1` FOREIGN KEY (`nr_pedido`) REFERENCES `pedidos` (`nr_pedido`),
  CONSTRAINT `pedidos_produtos_ibfk_2` FOREIGN KEY (`cd_produto`) REFERENCES `produtos` (`cd_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_produtos`
--

LOCK TABLES `pedidos_produtos` WRITE;
/*!40000 ALTER TABLE `pedidos_produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `cd_produto` int(11) NOT NULL,
  `ds_descricao` varchar(100) NOT NULL,
  `vl_preco_venda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cd_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Caneta esferográfica azul',1.50),(2,'Lápis preto HB',0.75),(3,'Borracha branca',0.50),(4,'Apontador',0.80),(5,'Caderno universitário 200 folhas',15.00),(6,'Agenda anual',12.00),(7,'Marcador de texto amarelo',2.00),(8,'Corretivo líquido',3.50),(9,'Régua 30cm',1.20),(10,'Tesoura escolar',4.00),(11,'Cola branca 90g',2.50),(12,'Papel sulfite A4 pacote 500 folhas',20.00),(13,'Bloco adesivo',5.00),(14,'Pastas plásticas',2.00),(15,'Clips para papel',1.00),(16,'Grampeador',10.00),(17,'Refil para grampeador',1.50),(18,'Caneta marca-texto',2.50),(19,'Calculadora simples',25.00),(20,'Caneta hidrográfica',3.00),(21,'Lápis de cor 12 cores',8.00),(22,'Pincel atômico',3.50),(23,'Fita adesiva transparente',1.80),(24,'Envelope pardo',0.60),(25,'Folhas pautadas',4.00),(26,'Papel cartão',2.20),(27,'Cartolina branca',1.00),(28,'Pasta catálogo',6.00),(29,'Livro de registro',12.00),(30,'Crachá plástico',0.90);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-24 18:06:51
