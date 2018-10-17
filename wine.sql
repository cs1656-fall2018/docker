
CREATE TABLE `product` (
  `PRODNR` char(6) NOT NULL,
  `PRODNAME` varchar(60) NOT NULL,
  `PRODTYPE` varchar(15) DEFAULT NULL,
  `AVAILABLE_QUANTITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`PRODNR`),
  UNIQUE KEY `UC1` (`PRODNAME`),
  KEY `PRODUCT_NAME_INDEX` (`PRODNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product` VALUES ('0119','Chateau Miraval, Cotes de Provence Rose, 2015','rose',126),('0154','Chateau Haut Brion, 2008','red',111),('0178','Meerdael, Methode Traditionnelle Chardonnay, 2014','sparkling',136),('0185','Chateau Petrus, 1975','red',5),('0199','Jacques Selosse, Brut Initial, 2012','sparkling',96),('0212','Billecart-Salmon, Brut Réserve, 2014','sparkling',141),('0219','Marques de Caceres, Rioja Crianza, 2010 ','red',0),('0238','Cos d\'Estournel, Saint - Estephe, 2006','red',50),('0265','Chateau Sociando-Mallet, Haut-Medoc, 1998','red',17),('0289','Chateau Saint Estève de Neri, 2015','rose',126),('0295','Chateau Pape Clement, Pessac-Léognan, 2001','red',75),('0300','Chateau des Rontets, Chardonnay, Birbettes','white',64),('0306','Chateau Coupe Roses, Granaxa, 2011','red',57),('0327','Chateau La Croix Saint-Michel, 2011','red',87),('0331','Chateau La Commanderie, Lalande-de-Pomerol, 1998','red',3),('0345','Vascosassetti, Brunello di Montalcino, 2004','red',64),('0347','Chateau Corbin-Despagne, Saint-Emilion, 2005','red',145),('0384','Dominio de Pingus, Ribera del Duero, Tempranillo, 2006','red',38),('0386','Chateau Haut-Bailly, Pessac-Leognan, Grand Cru Classe, 1968','red',118),('0404','Chateau Haut-Cadet, Saint-Emilion, 1997','red',115),('0468','Domaine Trapet Père & Fils, Gevrey-Chambertin, 2008','red',43),('0474','Chateau De La Tour, Clos-Vougeot, Grand cru, 2008','red',147),('0494','Veuve-Cliquot, Brut, 2012','sparkling',1),('0523','Chateau Andron Blanquet, Saint Estephe, 1979','red',13),('0632','Meneghetti, Chardonnay, 2010','white',83),('0637','Moët & Chandon, Rosé, Imperial, 2014','sparkling',121),('0639','Chateau Mouton-Rotshild, Pauillac, 2007','red',35),('0657','Le Brun Servenay, Brut, 2008','sparkling',34),('0668','Gallo Family Vineyards, Grenache, 2014','rose',95),('0760','Chateau Talbot, Saint-Julien, Grand Cru Classe, 2002','red',92),('0766','GH Mum, Brut, 2012','sparkling',68),('0783','Clos D\'Opleeuw, Chardonnay, 2012','white',8),('0795','Casa Silva, Los Lingues, Carmenere, 2012','red',105),('0832','Conde de Hervías,  Rioja, 2004','red',121),('0838','Piper Heidseck, Brut, 2014','sparkling',108),('0847','Seresin, Merlot, 1999','red',41),('0856','Domaine Chandon de Briailles, Savigny-Les-Beaune, 2006','red',93),('0885','Chateau Margaux, Grand Cru Classé, 1956','red',147),('0899','Trimbach, Riesling, 1989','white',142),('0900','Chateau Cheval Blanc, Saint Emilion, Grand Cru Classé, 1972','red',45),('0915','Champagne Boizel, Brut, Réserve, 2010','sparkling',76),('0977','Chateau Batailley, Grand Cru Classé, 1975','red',21);

CREATE TABLE `supplier` (
  `SUPNR` char(4) NOT NULL,
  `SUPNAME` varchar(40) NOT NULL,
  `SUPADDRESS` varchar(50) DEFAULT NULL,
  `SUPCITY` varchar(20) DEFAULT NULL,
  `SUPSTATUS` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`SUPNR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `supplier` VALUES ('21','Deliwines','240, Avenue of the Americas','New York',20),('32','Best Wines','660, Market Street','San Francisco',90),('37','Ad Fundum','82, Wacker Drive ','Chicago',95),('52','Spirits & co.','928, Strip','Las Vegas',NULL),('68','The Wine Depot','132, Montgomery Street','San Francisco',10),('69','Vinos del Mundo','4, Collins Avenue','Miami',92),('84','Wine Trade Logistics','1002, Rhode Island Avenue','Washington',92),('94','The Wine Crate','330, McKinney Avenue ','Dallas',75);

CREATE TABLE `purchase_order` (
  `PONR` char(7) NOT NULL,
  `PODATE` date DEFAULT NULL,
  `SUPNR` char(4) NOT NULL,
  PRIMARY KEY (`PONR`),
  KEY `SUPNR` (`SUPNR`),
  CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`SUPNR`) REFERENCES `supplier` (`SUPNR`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `purchase_order` VALUES ('1511','2015-03-24','37'),('1512','2015-04-10','94'),('1513','2015-04-11','37'),('1514','2015-04-12','32'),('1523','2015-04-19','37'),('1537','2015-04-27','69'),('1538','2015-05-01','68'),('1560','2015-05-05','32'),('1577','2015-05-10','37'),('1594','2015-05-13','37');

CREATE TABLE `supplies` (
  `SUPNR` char(4) NOT NULL,
  `PRODNR` char(6) NOT NULL,
  `PURCHASE_PRICE` decimal(8,2) DEFAULT NULL COMMENT 'PURCHASE_PRICE IN EUR',
  `DELIV_PERIOD` int(11) DEFAULT NULL COMMENT 'DELIV_PERIOD IN DAYS',
  PRIMARY KEY (`SUPNR`,`PRODNR`),
  KEY `PRODNR` (`PRODNR`),
  CONSTRAINT `supplies_ibfk_1` FOREIGN KEY (`SUPNR`) REFERENCES `supplier` (`SUPNR`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supplies_ibfk_2` FOREIGN KEY (`PRODNR`) REFERENCES `product` (`PRODNR`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `supplies` VALUES ('21','0119',15.99,1),('21','0178',NULL,NULL),('21','0289',17.99,1),('21','0327',56.00,6),('21','0347',16.00,2),('21','0384',55.00,2),('21','0386',58.99,2),('21','0468',14.99,5),('21','0668',6.00,1),('32','0154',21.00,4),('32','0474',40.00,1),('32','0494',15.00,2),('32','0657',44.99,4),('32','0760',52.00,3),('32','0832',20.00,2),('37','0178',16.99,4),('37','0185',32.99,3),('37','0468',14.00,1),('37','0795',20.99,3),('68','0178',17.99,5),('68','0212',27.99,6),('68','0300',19.00,1),('68','0327',56.99,4),('68','0468',15.99,4),('68','0637',81.00,2),('68','0639',5.00,5),('68','0668',6.99,3),('68','0760',52.99,2),('69','0178',16.99,NULL),('69','0199',32.00,4),('69','0347',18.00,4),('69','0783',7.00,3),('69','0795',20.99,1),('69','0832',21.00,4),('69','0977',34.99,1),('84','0185',33.00,5),('84','0300',21.00,2),('84','0306',25.00,2),('84','0347',18.00,4),('84','0468',15.00,2),('84','0494',15.99,2),('84','0832',20.99,6),('84','0915',84.00,3),('94','0154',22.00,2),('94','0178',18.00,6),('94','0185',32.99,1),('94','0199',30.99,1),('94','0474',39.99,2),('94','0523',20.99,3),('94','0632',15.99,2),('94','0899',15.00,1);

CREATE TABLE `po_line` (
  `PONR` char(7) NOT NULL,
  `PRODNR` char(6) NOT NULL,
  `QUANTITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`PONR`,`PRODNR`),
  KEY `PRODNR` (`PRODNR`),
  CONSTRAINT `po_line_ibfk_1` FOREIGN KEY (`PONR`) REFERENCES `purchase_order` (`PONR`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `po_line_ibfk_2` FOREIGN KEY (`PRODNR`) REFERENCES `product` (`PRODNR`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `po_line` VALUES ('1511','0212',2),('1511','0345',4),('1511','0783',1),('1511','0856',9),('1512','0178',3),('1512','0639',13),('1512','0885',3),('1512','0977',10),('1513','0295',9),('1513','0668',7),('1514','0185',2),('1514','0306',9),('1514','0847',9),('1514','0900',2),('1523','0347',1),('1523','0783',2),('1523','0900',3),('1523','0915',13),('1523','0977',1),('1537','0386',8),('1537','0632',2),('1537','0657',7),('1537','0766',2),('1538','0178',6),('1538','0212',15),('1560','0766',1),('1560','0795',3),('1560','0900',9),('1577','0212',6),('1577','0668',9),('1594','0306',2);
