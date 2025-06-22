-- Borra la base de datos con el nombre asignado.
-- Si no existe una base de datos con el nombre se debe borrar o comentar para que no cree problemas
DROP DATABASE MONSTERHUNTER;
-- Crea la base de datos y le da un nombre.
CREATE DATABASE MONSTERHUNTER;

-- Accede a la base de datos existente con ese nombre.
USE MONSTERHUNTER;

CREATE TABLE `BestImage`(
	`ID_IMAGE` integer 	UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`Path` varchar(255),
	`Description` varchar(255)
);

-- Crea la tabla de Clase de monstruo, con su identificador "ID_CLASS" como clave primaria.
-- También se crean las variables de texto "Name" y "Description".
-- "ID_CLASS" es el identificador único de la clase del monstruo (por ejemplo, wyvern, leviatán, etc.).
-- "Name" es el nombre de la clase de monstruo.
-- "Description" proporciona detalles sobre las características generales de esa clase.
CREATE TABLE `MonsterClass` (
	`ID_CLASS` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`Name` varchar(255),
	`Description` varchar(255)
);

-- Crea la tabla de debilidad, su clave primaria "ID_WEAKNESS" para poder identificarla.
-- Como atributo se crea la variable alfanumérica "Name".
-- "ID_WEAKNESS" es el identificador único de la debilidad del monstruo.
-- "Name" representa el nombre del tipo de debilidad (por ejemplo, fuego, agua, rayo, etc.).
CREATE TABLE `Weakness` (
	`ID_WEAKNESS` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`ID_IMAGE` integer,
	`Name` varchar(255),
	CONSTRAINT FK_ID_IMAGE_WEAKNESS FOREIGN KEY(ID_IMAGE) REFERENCES BestImage(ID_IMAGE) 
);

-- Crea la tabla de estado, creando también la clave primaria "ID_STATE" para identificarla.
-- También crea los atributos "Name" y "Description" que son alfanuméricos.
-- "ID_STATE" es el identificador único del estado.
-- "Name" representa el nombre del estado (por ejemplo, enfurecido, dormido, etc.).
-- "Description" contiene una breve explicación del efecto del estado sobre el monstruo.
CREATE TABLE `State` (
	`ID_STATE` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`Name` varchar(255),
	`Description` varchar(255)
);

-- La instrucción "Create Table Element" crea la tabla con el nombre "Element".
-- El identificador del elemento "ID_ELEMENT".
-- Referencia a la entidad "State" con la clave foránea 
-- "Name" es el nombre del elemento.
CREATE TABLE `Element` (
	`ID_ELEMENT` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`ID_STATE` integer,
	`Name` varchar(255),
	`Description` varchar(255)
);

-- "Create Table Monster" Crea la tabla y le da el nombre de "Monster".
-- Siendo “ID_MONSTER” el identificador del monstruo.
-- Referenciando a las entidades de  “Type”, “Element”, “State” y “Weakness”, para obtener información.
-- "Quantity" la cantidad de monstruos cazados.
-- "Size" el tamaño del monstruo.
-- "Description" es la descripción del monstruo.
-- "Notes" información de alguna conducta o algún dato que sirva para las cacerías.
-- "Name" nombre del monstruo.
CREATE TABLE `Monster` (
	`ID_MONSTER` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `ID_CLASS` integer,
	`ID_ELEMENT` integer,
	`ID_STATE` integer,
	`ID_WEAKNESS` integer,
	`Name` varchar(255),
	`Description` varchar(500),
	`Habitat` varchar(255),
    `Notes` varchar(255),
    `MaxSize` float,
	`MinSize` float
);

-- Crea la referencia con la entidad Element usando la clave foránea desde la entidad Monster
ALTER TABLE `Monster` ADD CONSTRAINT `FK_ID_ELEMENT` FOREIGN KEY (`ID_ELEMENT`) REFERENCES `Element` (`ID_ELEMENT`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Crea la referencia con la entidad State usando la clave foránea desde la entidad Monster
ALTER TABLE `Monster` ADD CONSTRAINT `FK_ID_STATE` FOREIGN KEY (`ID_STATE`) REFERENCES `State` (`ID_STATE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Crea la referencia con la entidad Weakness usando la clave foránea  en la entidad Monster
ALTER TABLE `Monster` ADD CONSTRAINT `FK_ID_WEAKNESS` FOREIGN KEY (`ID_WEAKNESS`) REFERENCES `Weakness` (`ID_WEAKNESS`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Crea la referencia con la entidad State usando la clave foránea  en la entidad Element
ALTER TABLE `Element` ADD CONSTRAINT `FK_ID_STATE_ELEMENT` FOREIGN KEY (`ID_STATE`) REFERENCES `State` (`ID_STATE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Aquí se genera la referencia a la entidad de Type dentro de la entidad de Monstruo
ALTER TABLE `Monster` ADD CONSTRAINT `FK_ID_CLASS` FOREIGN KEY (`ID_CLASS`) REFERENCES `Type` (`ID_CLASS`) ON DELETE NO ACTION ON UPDATE NO ACTION;


INSERT INTO `Images`(Path, Description) VALUES
('Assets/Images/Elements/Elemento_Fuego.png', 'Elemnto Fuego'),
('Assets/Images/Elements/Elemento_Agua.png', 'Elemento Agua'),
('Assets/Images/Elements/Elemento_Rayo.png', 'Elemento Rayo'), 
('Assets/Images/Elements/Elemento_Hielo.png', 'Elemento Hielo'),
('Assets/Images/Elements/Elemento_Draco.png', 'Elemento Draco'),
('Assets/Images/Elements/Estado_Nitro.png', 'Estado Nitro'),
('Assets/Images/Elements/Estado_Veneno.png', 'Estado Veneno'),
('Assets/Images/Elements/Estado_Paralisis.png', 'Estado Paralisis'),
('Assets/Images/Elements/Estado_Sueño.png', 'Estado Sueño'),
('Assets/Images/Elements/Estado_Aturdido.png', 'Estado Aturdido'),
('Assets/Images/Elements/Estado_DefensaRed.png', 'Estado Defensa Reducida'),
('Assets/Images/Elements/Estado_DefensaSev.png', 'Estado Defensa Muy Reducida'),
('Assets/Images/Elements/Estado_AzoteNitro.png', 'Estado Azote Nitro'),
('Assets/Images/Elements/Estado_Sangrado.png', 'Estado Sangrado'),
('Assets/Images/Elements/Estado_Efluvio.png', 'Estado Acumulación de Efluvio'),
;

INSERT INTO `Type` (ID_TYPE, Name, Description) VALUES 
(1, 'Bestia de Colmillo', 'Criaturas cuadrúpedas ágiles y feroces que cazan usando colmillos y garras.'),
(2, 'Dracoalado', 'Reptiles con alas, similares a dragones, capaces de volar y usar alientos elementales.'),
(3, 'Dragon Anciano', 'Seres míticos extremadamente poderosos que desafían la lógica natural.'),
(4, 'Herbíboro', 'Monstruos pasivos que se alimentan de plantas y rara vez atacan si no son provocados.'),
(5, 'Lynian', 'Especies inteligentes y pequeñas, algunas son amistosas y otras hostiles.'),
(6, 'Wyvern Bruto', 'Monstruos grandes, extremadamente agresivos, con cuerpo robusto y ataques devastadores.'),
(7, 'Wyvern de Colmillos', 'Wyverns con mandíbulas prominentes que combinan fuerza física con velocidad.'),
(8, 'Wyvern Nadador', 'Wyverns adaptados a hábitats acuáticos o pantanosos, con gran movilidad en esos entornos.'),
(9, 'Wyvern Pájaro', 'Wyverns ligeros y veloces con aspecto de aves, especializados en emboscadas y agilidad.'),
(10, 'Wyvern Volador', 'Wyverns clásicos con alas fuertes que les permiten surcar los cielos con facilidad.');

INSERT INTO `Weakness` (ID_WEAKNESS, Name) VALUES
(1, 'Fuego'),
(2, 'Agua'),
(3, 'Rayo'),
(4, 'Hielo'),
(5, 'Draco'),
(6, 'Explosivo'),
(7, 'Veneno');

INSERT INTO `State` (ID_STATE, Name, Description) VALUES
(1, 'Plaga de Fuego', 'Estado donde el cazador irá reduciendo poco a poco la vida del cazador al estar quemándose. '),
(2, 'Plaga de Agua', 'Estado que reduce la velocidad de recuperación de resistencia del cazador.'),
(3, 'Plaga de Rayo', 'Estado que umenta la probabilidad de que el cazador quede aturdido con ciertos ataques.' ),
(4, 'Plaga de Hielo', ' Estado aumenta la velocidad de consumo de resistencia haciendo que se gaste más rápido.'),
(5, 'Plaga de Draco', 'Estado que anula el atributo del arma.'),
(6, 'Plaga de Nitro','Estado que cubre al cazador de una sustancia volátil que explotará transcurrido un tiempo o al recibir un ataque.'),
(7, 'Veneno', 'Reduce gradualmente la salud del cazador durante cierto tiempo.'),
(8, 'Paralisis', 'El cazador quedará inmovilizado en el suelo mientras rayos amarillos surcan su cuerpo.'),
(9, 'Sueño', ' El cazador andará adormecido durante unos segundos antes de caer dormido.'),
(10, 'Aturdimiento', 'El cazador se quede mareado sin poder moverse, indicado como estrellas dando vueltas sobre su cabeza.'),
(11, 'Defensa reducida','Estado anormal causado por sustancias corrosivas que debilitan la armadura del cazador'),
(12, 'Defensa muy reducida', 'Verión más potente de la defensa reducida'),
(13, 'Azote de Nitro','Versión más potente que la Plaga de nitro más difícil de quitar y causa más daño.'),
(14, 'Sangrado','Estado donde el cazador recibe daño al moverse'),
(15, 'Acumulación de efluvio',' Estado donde disminuye la capacidad máxima de tu barra de salud, reduciéndola a 100. El uso de Pociones Máximas o Pociones Antiguas no tiene efecto mientras dure este estado.');

INSERT INTO `Element` (ID_ELEMENT, ID_STATE, Name, Description) VALUES
(1, 1, 'Fuego', 'Los ataques de fuego consisten en explosiones, llamaradas, bolas de fuego, rayos térmicos, gases ardientes u otros ataques a alta temperatura. Consumen todo a su alrededor, reduciendo a cenizas o causando quemaduras graves a sus víctimas.'),
(2, 2, 'Agua', 'Los ataques de agua suelen consistir en proyectiles de agua, potentes chorros a presión, salpicaduras o corrientes fuertes.'),
(3, 3, 'Rayo', 'Los ataques de rayo consisten en relámpagos, descargas eléctricas, chispazos o proyectiles de electricidad.'),
(4, 4, 'Hielo', 'Los ataques de hielo consisten principalmente en golpear con partes congeladas, viento helado, proyectiles de hielo o congelación espontánea del aire.'),
(5, 5, 'Draco', 'Los ataques de draco recuerdan a veces a los de Elemento Trueno, consistentes en rayos de color negro y rojo, aunque también se pueden mostrar como una especie de vapor negro y rojo.'),
(6, 10, 'Ninguno','Ninguno');

INSERT INTO `Monster`(ID_CLASS, ID_ELEMENT, ID_STATE, ID_WEAKNESS, Name, Description,Habitat,Notes, MaxSize , MinSize) VALUES
 (10, 6, 10, 3, 'Diablos', 'El mayor depredador del Yermo de Agujas. Una bestia amenazadora y muy territorial, 
que se esconde bajo la tierra. Los ruidos fuertes lo hacen salir en busca de presas a las que arrastrar bajo las arenas.', 'Yermo de Agujas','Los Diablos son capaces de excavar y moverse a gran velocidad bajo tierra.
 Su oído muy agudo, por lo que cuando está bajo la arena se le puede aturdir con una bomba sónica.', 3030.0, 1797.0),
 (10, 6, 10, 3, 'Diablos negra', 'Su aspecto es el de un Diablos de caparazón negro, pero en realidad son Diablos hembra en celo.
 Su coloración es una señal que advierte de la agresividad extrema de estas bestias.', 'Yermo de Agujas', 'Esta agresividad se evidencia en los combates, con un aumento significativo de la velocidad y una fuerza mayor. 
 Además posee mayor habilidad al excavar y se catapulta más frecuentemente desde el subsuelo.', 2930.3, 1893.7),
 (10, 1, 1, 3, 'Rathian', '	Wyverns conocidas como "reinas de la tierra". Depredadoras terrestres que dominan a sus presas con su cola venenosa y poderosas patas.',
 'Bosque primigenio, Yermo de Agujas', 'La Rathian ataca principalmente con embestidas y coletazos.Su ataque más característico consiste en dar una mortal para golpear con su cola venenosa,
 pudiendo hacerlo tanto en tierra como en el aire.', 2303.8, 1151.9),
 (10, 1, 1, 3, 'Rathian Rosa', 'Subespecie de Rathian con escamas de color rosa brillante. Estas Rathian sacuden sus tóxicas colas con aún más destreza que las Rathian normales, 
 hiriendo a su presa con veneno antes de rematarla.', 'Bosque primigenio, Yermo de Agujas, Altiplanos Coralinos', 
 'Puede lanzar poderosas bolas de fuego o crear explosiones al morder y es más veloz al atacar y embestir.', 2303.8, 1151.9),
 (10, 1, 1, 3, 'Rathalos', 'El mayor depredador del Bosque Primigenio, también conocido como "rey de los cielos". 
 Un terrible monstruo que ataca a todo invasor con garras venenosas y aliento de fuego.', 'Bosque Primigenio', 'El Rathalos tiene una gran variedad de ataques aéreos, como lanzar tres bolas de fuego, 
 embestir al cazador con sus garras venenosas dejándolo aturdido y envenenado.', 2248.6, 1140.6),
 (10, 1, 1, 3, 'Rathalos Celeste', 'Una subespecie de Rathalos de color azulado. De más movilidad que sus primos convencionales, a menudo localizan a sus presas desde las alturas y se lanzan sobre ellas.'
 , 'Bosque Primigenio, Lecho de los Ancianos', 'Las fuertes alas del Rathalos Celeste le permiten volar durante mayor tiempo y con mayor eficacia que el Rathalos común, y la presión de aire que crean sus alas es mayor.',
 2248.6, 1140.6),
 (3, 3, 3, 1, 'Kirin', 'Los Kirin son tan difíciles de ver que poco se sabe de su ecología. Se dice que al provocarles sus cuerpos quedan envueltos en electricidad pura.', 
 'Altiplanos Coralinos', ' Su habilidad principal consiste en invocar rayos para atacar en combate, pudiendo lanzar una lluvia de rayos a su alrededor o en frente suyo.', 
 928.6, 371.4),
 (8, 1, 1, 2, 'Lavasioth', 'Los Lavasioth utilizan lava líquida como armadura. Son extremadamente agresivos y atacan sin tregua hasta eliminar a la amenaza en cuestión.',
 'Lecho de los Ancianos', 'Puede disparar enormes bolas magmáticas a los cazadores, y cuando caen al suelo, sueltan trozos de roca ardiente que pueden dañar a los cazadores.',
 3403.7, 1800.8),
 (3, 1, 1, 2, 'Toestra', 'Dragones ancianos de gran brutalidad, siempre envueltos en llamas y escupiendo fuego puro. Debido a la fiereza y letalidad de los Teostra el gremio estudia con detalle sus movimientos.',
 'Yermo de Agujas, Lecho de los Ancianos', 'Lo que más destaca de este monstruo es su uso de polvos explosivos para atacar, primero los expande con sus alas y luego los hace explotar al chasquear sus colmillos.',
  2610, 1496.4),
 (3, 1, 1, 4, 'Lunastra', 'Una dragona anciana muy escasa que llena el aire de polvo azul ardiente. Los rumores dicen que viaja junto a su pareja, el Teostra.',
 'Yermo de Agujas, Lecho de los Ancianos, Tierras Destino', 'Al igual que el Teostra, durante la batalla liberará un polvo inflamable que extenderá con sus alas por la zona, y que puede hacer explotar con una chispa al chocar sus colmillos.',
  2575.2, 1444.2),
 (3, 6, 10, 1, 'Kushala Daora', 'Un dragón anciano envuelto en torbellinos de viento que dificultan acercarse a él. Tiene la piel recubierta de duras escamas metálicas.',
 'Bosque Primigenio, Lecho de los Ancianos, Tierras Destino', 'La habilidad más destacable del Kushala Daora es su habilidad de llevar tormentas allá por donde va y de manipular los vientos de forma ofensiva y defensiva. Es capaz de lanzar proyectiles de viento e incluso generar huracanes y ventiscas.',
 2215.6, 1261.6),
 (6, 2, 2, 4, 'Barroth', 'Los Barroth pasan gran parte de su tiempo buscando hormigas, su alimento principal, y marcando su territorio con barro. Si se enfrentan a un enemigo, su seña de identidad es una carga muy poderosa.',
 'Yermo de Agujas', 'Utiliza su gran cresta para intentar aplastar a sus enemigos y embestirlos con furia ciega. También puede atacar con la cola y agitarse para lanzar barro a sus enemigos.', 2039.723, 1217.1),
 (6, 5, 11,3, 'Deviljho','Debido a su metabolismo, los Deviljho siempre andan buscando presas. Son muy agresivos, y a menudo se les ve con las fauces clavadas en grandes monstruos y sacudiéndolos por los aires.',
 'Todos', ' Al enfurecerse, sus músculos se hinchan y enrojecen, y puede atacar con un aliento de elemento dragón de rango considerable. Por otro lado, su saliva es ácida, por lo que sus mordidas causan Defensa reducida cuando está cansado.',
 4097.8 , 1803),
 (6, 1, 9, 2, 'Uragaan', 'Grandes y brutales wyverns que se alimentan de minerales, haciendo crujir rocas enormes hasta pulverizarlas con sus poderosísimas mandíbulas. Al parecer, no es infrecuente verles librando disputas territoriales con Lavasioth.',
 'Lecho de los Ancianos', 'El Uragaan tiene una habilidad única de enrollarse y rodar como una rueda para intentar aplastar al cazador, de ahí que sus protuberancias sean planas por encima.',
 3344.48, 410.06),
 (6, 1, 1, 2, 'Anjanath', 'Los Anjanath patrullan por el Bosque Primigenio en busca de su comida preferida, los Aptonoth. Este agresivo monstruo ataca a cualquiera sin titubear.',
 'Bosque Primigenio, Yermo de Agujas', 'De forma similar al Glavenus, un órgano en su garganta le permite imbuir su boca en llamas, pudiendo luego expulsar llamaradas para atacar o dar mordiscos.',
 2395.303, 1504.094),
 (6, 6, 9, 4, 'Radobaan', 'Un wyvern brutal gigantesco que se alimenta de huesos de cadáveres que encuentra en el Valle Putrefacto. También es capaz de usar los huesos como armadura, y se enrolla como una bola para atacar y desplazarse.',
 'Valle Putrefacto', 'El Radobaan puede parar en seco al rodar y rápidamente corregir su trayectoria para golpear, también es capaz de rodar por el suelo a gran velocidad como una peonza.',
 0, 0),
 (7, 6, 14, 4, 'Odogaron', 'Terrorífico monstruo que recorre el Valle Putrefacto en busca de carroña. Su naturaleza agresiva convierte a cualquiera, sea monstruo o persona, en una cena potencial.',
  'Valle Putrefacto, Altiplanos Coralinos, Tierras Destino', 'Sus temibles garras aserradas pueden causar hemorragias que dificultan la curación de los cazadores.',
  1735.94, 541.61),
 (7, 6, 6, 3, 'Dodogama', '	Un monstruo cuya dieta se basa en devorar rocas. Los cristales que devora se mezclan con su saliva para producir minerales explosivos que escupe a sus enemigos.',
 'Lecho de los Ancianos', ' Su habilidad más temible es la de escupir las rocas que ha consumido como proyectiles que explotan al caer, pudiendo lanzarlos de diversas formas incluyendo un poderoso ataque en área.',
 2000, 977.78),
 (9, 6, 10, 3, 'Tzitzi-Ya-Ku', 'Extraño monstruo que ciega tanto a presas como a enemigos con los destellos de un órgano especial cerca de su cabeza, para a continuación rematarlos con sus fuertes patas.', 
'Altiplanos Coralinos', 'Utiliza ataques de luz para desorientar al cazador.',
 1200.0, 700.0),
(10, 6, 10,3, 'Paolumu', 'Los Paolumu se dan auténticos festines de huevos en los Altiplanos Coralinos. Los peculiares sacos de aire de su cuerpo les permiten flotar en el aire y atacar con su durísima cola.', 
'Altiplanos Coralinos', 'Se desplaza flotando y puede atacar con ráfagas de viento.',
 1500.0, 900.0),
(8, 2, 2, 2, 'Jyuratodus', 'Un gran wyvern nadador que habita en los pantanos del Yermo de Agujas. Se ayuda del barro para capturar a sus presas, y a veces se le puede ver peleando por su territorio con Barroth.', 
'Yermo de Agujas', 'Puede cubrirse de barro para defenderse y atacar.',
 2100.877, 1358.007),
(9, 6, 7, 3, 'Pukei-Pukei', 'Wyvern pájaro conocido por las toxinas venenosas de su cuerpo. A menudo almacena fragmenueces en la boca o la cola, lo que las cubre de veneno y las hace útiles como proyectiles contra cualquier amenaza.', 
'Bosque Primigenio, Yermo de Agujas', 'Suelta un gas venenoso para dificultar la visión.',
  1344.99, 970.16),
(7, 3, 3, 2, 'Tobi-Kadachi', 'Wyvern de grandes colmillos que vuela entre los árboles del Bosque Primigenio. Es capaz de utilizar a su favor la electricidad estática que acumula al frotarse con los árboles mientras se mueve.',
 'Bosque Primigenio', 'Puede escalar paredes y atacar con electricidad.',
 1300.0, 700.0),
(7, 6, 15, 1, 'Jagras', 'Miembros de la manada de un Gran Jagras. Si ven morir a uno de los suyos huirán, pero también se les ha visto emboscar a monstruos grandes en cortos espacios de tiempo.',
 'Bosque Primigenio', 'Se agrupa en manadas y es uno de los primeros depredadores a los que enfrentarse.',
 700.0, 300.0),
(7, 6, 10, 1, 'Gran Jagras', 'El lider de una manada de Jagras. Son muy voraces: los grandes Jagras hambrientos atacan a monstruos mas fuertes que ellos, y cuando tienen el estomago lleno este puede hincharse hasta alcanzar un gran tamaño.', 
'Bosque Primigenio', 'Se infla tras comer y es territorial.',
 1590.993, 976.600),
(7, 6, 8, 2, 'Girros', 'Monstruos que atacan en grupo utilizando a su favor los gases letales del Valle Putrefacto. También son capaces de mutilar a sus víctimas con sus colmillos paralizantes.',
 'Valle Putrefacto', 'Ataca en manadas y puede ser peligroso si se le provoca.',
 500.0, 300.0),
(7, 6, 8, 2, 'Gran Girros', 'Monstruo que se alimenta rapiñando los restos de comida caídos de los Altiplanos Coralinos. Actúan como líderes en las manadas de Girros, y cuentan con colmillos paralizantes de gran tamaño.',
 'Valle Putrefacto', 'Ataca en manada y tiene veneno fuerte.',
 1400.0, 900.0),
(7, 6, 10, 1, 'Shamos', 'Pequeños monstruos nocturnos. Son especialmente vulnerables a los fogonazos cegadores del Tzitzi-Ya-Ku, pero si se juntan en un buen grupo pueden ser una amenaza.',
 'Altiplanos Coralinos', 'Muy comunes, se mueven en grupos y atacan con embestidas rápidas.',
 200.0, 150.0),
(10, 4, 4, 3, 'Legiana','El mayor depredador de los Altiplanos Coralinos. Su dieta se basa en los Raphinos, a los que caza con ráfagas de viento helado que emite su cuerpo y que dificulta la huida de sus víctimas.',
 'Altiplanos Coralinos, Arroyo de Escarcha, Tierras Destino', 'Ataca con ráfagas de viento helado.',
 2124.69, 1495.78),
(10, 1, 1, 4, 'Bazelgeuse', 'Un malvado wyvern volador que se ha desplazado al Nuevo Mundo en busca de presas. Para cazar esparce escamas explosivas por amplias superficies, para alimentarse de criaturas atrapadas en la explosión.',
 'Bosque Primigenio, Yermo de Agujas, Altiplanos Coralinos, Valle Putrefacto, Lecho de los Ancianos', 'Sus escamas caen y explotan causando daño masivo.', 
3000.0, 1600.0),
(3, 3, 10, 5, 'Vaal Hazak', 'Wyvern que domina la necrosis y ataques de gas venenoso.', 
'Valle Putrefacto', 'Puede causar drenaje de vida al cazador.', 
2600.0, 1400.0),
(3, 5, 10, 1, 'Nergigante', 'Un dragón anciano feroz conocido por su resistencia y ataques punzantes.', 
'Tierras Destino', 'Se regenera y sus púas son letales.', 
3000.0, 1800.0),
(3, 1, 10, 4, 'Zorah Magdaros', 'Gigantesco dragón que aparece en la zona volcánica.', 
'Volcán', 'Aparece como evento especial.', 
15000.0, 13000.0)
;
INSERT INTO `Monster`(ID_CLASS, ID_ELEMENT, ID_STATE, ID_WEAKNESS, Name, Description, Habitat, Notes, MaxSize, MinSize) VALUES
(5, 6, 10, 7, 'Kulu-Ya-Ku', 'Lynian que roba objetos y usa herramientas para defenderse.', 'Bosque Primigenio', 'Conocido por robar huevos y atacar con objetos.', 800.0, 400.0),
(5, 6, 10, 7, 'Wulg', 'Lynian que se desplaza rápido y ataca en manada.', 'Bosque Primigenio', 'Ataques coordinados y rápidos.', 600.0, 350.0),
(6, 1, 10, 3, 'Tigrex', 'Wyvern brutal que ataca con embestidas y rugidos.', 'Yermo de Agujas', 'Muy agresivo y difícil de esquivar.', 2800.0, 1500.0),
(6, 4, 10, 3, 'Brachydios Colerico', 'Variante agresiva que usa explosiones de mucosa.', 'Bosque Primigenio', 'Ataques explosivos con mucosa.', 2900.0, 1500.0),
(6, 4, 10, 5, 'Beotodus', 'Wyvern que nada y caza bajo el hielo con colmillos afilados.', 'Zona Ártica', 'Especialista en ataques bajo hielo.', 2600.0, 1400.0),
(6, 1, 10, 3, 'Barioth', 'Wyvern ágil que usa hielo y ataques rápidos.', 'Zona Ártica', 'Muy móvil y agresivo.', 2100.0, 1200.0),
(6, 1, 10, 5, 'Shara Ishvalda', 'Wyvern antiguo que controla viento y tierra.', 'Gran Bosque', 'Evento especial, muy raro.', 3500.0, 2000.0),
(6, 5, 10, 2, 'Velkhana', 'Wyvern anciano que domina el hielo y puede congelar el entorno.', 'Zona Ártica', 'Jefe principal en Iceborne.', 3400.0, 1800.0),
(6, 3, 10, 5, 'Namielle', 'Wyvern anciano que usa agua y electricidad.', 'Bosque Sumergido', 'Combina ataques eléctricos y acuáticos.', 3300.0, 1600.0),
(6, 2, 10, 4, 'Tzitzi-Ya-Ku', 'Wyvern que aturde con destellos de luz cegadora.', 'Bosque Primigenio', 'Ataques de luz para desorientar.', 1200.0, 700.0),
(6, 1, 10, 3, 'Rajang', 'Wyvern feroz con ataques eléctricos y mucha fuerza.', 'Montañas', 'Muy agresivo y fuerte.', 2800.0, 1500.0),
(6, 4, 10, 6, 'Safi\'jiiva', 'Wyvern anciano que absorbe energía vital.', 'Lecho de los Ancianos', 'Evento de mundo, muy peligroso.', 4000.0, 2500.0),
(6, 2, 10, 5, 'Fulgur Anjanath', 'Variante de Anjanath con ataques eléctricos.', 'Bosque Primigenio', 'Ataques potenciados con electricidad.', 3500.0, 1500.0),
(6, 3, 10, 4, 'Gold Rathian', 'Variante de Rathian con escamas doradas y ataques potentes.', 'Lecho de los Ancianos', 'Más agresiva que la original.', 3100.0, 1700.0),
(4, 6, 10, 1, 'Aptonoth', 'Un herbívoro pacífico que suele ser presa fácil para los depredadores. Se mueve en manadas por el bosque y la llanura.',
 'Bosque Primigenio, Llanura', 'Se puede montar para desplazarse rápidamente y huir de los peligros.', 150.0, 100.0),
(1, 6, 10, 1, 'Wulg', 'Depredador pequeño y ágil que suele cazar en grupo y aprovechar emboscadas.',
 'Bosque Primigenio', 'Muy rápido y ágil, difícil de atrapar.', 600.0, 350.0),
(5, 1, 1, 7, 'Vespoid', 'Insecto volador que ataca en enjambres y puede lanzar ataques venenosos.',
 'Bosque Primigenio', 'Ataques rápidos y en grupo, puede envenenar al cazador.', 250.0, 150.0),
(4, 6, 10, 1, 'Kestodon', 'Herbíboro pequeño con cuernos, que se mueve en manadas y huye ante la amenaza.',
 'Bosque Primigenio', 'Se pueden montar para escapar rápidamente.', 120.0, 90.0),
(5, 1, 1, 7, 'Hornetaur', 'Insectos voladores grandes que atacan con aguijones venenosos y mandíbulas fuertes.',
 'Bosque Primigenio', 'Ataques venenosos, voladores y agresivos.', 350.0, 280.0),
(4, 6, 10, 1, 'Popo', 'Herbíboros pequeños que se mueven en manadas, con cuernos afilados.',
 'Bosque Primigenio', 'Pacíficos, son alimento común para depredadores.', 100.0, 80.0),
(4, 6, 10, 1, 'Apceros', 'Monstruos herbívoros con cuernos pequeños que suelen huir de los depredadores.',
 'Bosque Primigenio', 'Se puede montar para desplazarse.', 110.0, 90.0);
;


-- SELECT con JOIN 1
-- Muestra el nombre del monstruo y su clase usando la tabla MonsterClass
SELECT monster.Name AS "Nombre", MonsterClass.Name AS "Clase"
FROM monster
JOIN MonsterClass ON monster.ID_CLASS = MonsterClass.ID_CLASS;

-- SELECT con JOIN 2
-- Muestra el nombre del monstruo, el nombre del elemento y el estado asociado al elemento
SELECT monster.Name AS "Monstruo", element.Name AS "Elemento", state.Name AS "Estado"
FROM monster
JOIN element ON monster.ID_ELEMENT = element.ID_ELEMENT
JOIN state ON element.ID_STATE = state.ID_STATE;

-- SELECT con WHERE y ORDER 3
-- Muestra los monstruos con debilidad al 'Fuego', ordenados por tamaño máximo descendente
SELECT monster.Name AS "Nombre", weakness.Name AS "Debilidad", monster.MaxSize
FROM monster
JOIN weakness ON monster.ID_WEAKNESS = weakness.ID_WEAKNESS
WHERE weakness.Name = 'Fuego'
ORDER BY monster.MaxSize DESC;

-- SELECT con WHERE y ORDER 4
-- Muestra los monstruos con tamaño mínimo menor a 500, ordenados alfabéticamente por nombre
SELECT Name, MinSize
FROM monster
WHERE MinSize < 500
ORDER BY Name ASC;

-- SELECT con WHERE y ORDER 5
-- Muestra los monstruos que viven en el 'Valle Putrefacto', ordenados por tamaño máximo ascendente
SELECT Name, Habitat, MaxSize
FROM monster
WHERE Habitat LIKE '%Valle Putrefacto%'
ORDER BY MaxSize ASC;

-- SELECT con WHERE y ORDER 6
-- Muestra los monstruos con elemento 'Hielo', ordenados por tamaño mínimo descendente
SELECT monster.Name AS "Monstruo", element.Name AS "Elemento", monster.MinSize
FROM monster
JOIN element ON monster.ID_ELEMENT = element.ID_ELEMENT
WHERE element.Name = 'Hielo'
ORDER BY monster.MinSize DESC;

-- UPDATE 1
-- Actualiza el hábitat del monstruo 'Barioth' a 'Zona Glacial'
UPDATE monster
SET Habitat = 'Zona Glacial'
WHERE Name = 'Barioth';

-- UPDATE 2
-- Cambia la debilidad del monstruo 'Deviljho' a 'Fuego'
UPDATE monster
SET ID_WEAKNESS = (
    SELECT ID_WEAKNESS FROM weakness WHERE Name = 'Fuego'
)
WHERE Name = 'Deviljho';

-- DELETE
-- Elimina el monstruo llamado 'Apceros'
DELETE FROM monster
WHERE Name = 'Apceros';

-- INSERT
-- Inserta un nuevo monstruo llamado 'Gran Vespoid' usando valores compatibles y existentes
INSERT INTO monster (ID_CLASS, ID_ELEMENT, ID_STATE, ID_WEAKNESS, Name, Description, Habitat, Notes, MaxSize, MinSize)
VALUES (
    5, 1, 1, 7,
    'Gran Vespoid',
    'Insecto volador de gran tamaño que ataca en enjambres venenosos.',
    'Bosque Primigenio',
    'Es una versión más grande de los Vespoid, con ataques más potentes.',
    500.0, 300.0
);