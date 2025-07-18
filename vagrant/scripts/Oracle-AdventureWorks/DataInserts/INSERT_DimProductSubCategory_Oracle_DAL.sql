TRUNCATE TABLE DimProductSubcategory;

INSERT INTO DimProductSubcategory(ProductSubcategoryKey, ProductSubcategoryAlternateKey, EnglishProductSubcategoryName, SpanishProductSubcategoryName, FrenchProductSubcategoryName, ProductCategoryKey)
SELECT 1, 1, N'Mountain Bikes', N'Bicicleta de monta�a', N'VTT', 1 FROM DUAL UNION ALL
SELECT 2, 2, N'Road Bikes', N'Bicicleta de carretera', N'V�lo de route', 1 FROM DUAL UNION ALL
SELECT 3, 3, N'Touring Bikes', N'Bicicleta de paseo', N'V�lo de randonn�e', 1 FROM DUAL UNION ALL
SELECT 4, 4, N'Handlebars', N'Barra', N'Barre d''appui', 2 FROM DUAL UNION ALL
SELECT 5, 5, N'Bottom Brackets', N'Eje de pedalier', N'Axe de p�dalier', 2 FROM DUAL UNION ALL
SELECT 6, 6, N'Brakes', N'Frenos', N'Freins', 2 FROM DUAL UNION ALL
SELECT 7, 7, N'Chains', N'Cadena', N'Cha�ne', 2 FROM DUAL UNION ALL
SELECT 8, 8, N'Cranksets', N'Bielas', N'P�dalier', 2 FROM DUAL UNION ALL
SELECT 9, 9, N'Derailleurs', N'Desviador', N'D�railleur', 2 FROM DUAL UNION ALL
SELECT 10, 10, N'Forks', N'Horquilla', N'Fourche', 2 FROM DUAL UNION ALL
SELECT 11, 11, N'Headsets', N'Direcci�n', N'Jeu de direction', 2 FROM DUAL UNION ALL
SELECT 12, 12, N'Mountain Frames', N'Cuadro de monta�a', N'Cadre de VTT', 2 FROM DUAL UNION ALL
SELECT 13, 13, N'Pedals', N'Pedal', N'P�dale', 2 FROM DUAL UNION ALL
SELECT 14, 14, N'Road Frames', N'Cuadro de carretera', N'Cadre de v�lo de route', 2 FROM DUAL UNION ALL
SELECT 15, 15, N'Saddles', N'Sill�n', N'Selle', 2 FROM DUAL UNION ALL
SELECT 16, 16, N'Touring Frames', N'Cuadro de paseo', N'Cadre de v�lo de randonn�e', 2 FROM DUAL UNION ALL
SELECT 17, 17, N'Wheels', N'Rueda', N'Roue', 2 FROM DUAL UNION ALL
SELECT 18, 18, N'Bib-Shorts', N'Culote corto', N'Cuissards avec bretelles', 3 FROM DUAL UNION ALL
SELECT 19, 19, N'Caps', N'Gorra', N'Casquette', 3 FROM DUAL UNION ALL
SELECT 20, 20, N'Gloves', N'Guantes', N'Gants', 3 FROM DUAL UNION ALL
SELECT 21, 21, N'Jerseys', N'Jersey', N'Maillot', 3 FROM DUAL UNION ALL
SELECT 22, 22, N'Shorts', N'Pantalones cortos', N'Cuissards', 3 FROM DUAL UNION ALL
SELECT 23, 23, N'Socks', N'Calcetines', N'Chaussettes', 3 FROM DUAL UNION ALL
SELECT 24, 24, N'Tights', N'Mallas', N'Collants', 3 FROM DUAL UNION ALL
SELECT 25, 25, N'Vests', N'Camiseta', N'Veste', 3 FROM DUAL UNION ALL
SELECT 26, 26, N'Bike Racks', N'Portabicicletas', N'Porte-v�lo', 4 FROM DUAL UNION ALL
SELECT 27, 27, N'Bike Stands', N'Soporte para bicicletas', N'Range-v�lo', 4 FROM DUAL UNION ALL
SELECT 28, 28, N'Bottles and Cages', N'Portabotellas y botella', N'Bidon et porte-bidon', 4 FROM DUAL UNION ALL
SELECT 29, 29, N'Cleaners', N'Limpiador', N'Nettoyant', 4 FROM DUAL UNION ALL
SELECT 30, 30, N'Fenders', N'Guardabarros', N'Garde-boue', 4 FROM DUAL UNION ALL
SELECT 31, 31, N'Helmets', N'Casco', N'Casque', 4 FROM DUAL UNION ALL
SELECT 32, 32, N'Hydration Packs', N'Sistema de hidrataci�n', N'Sac d''hydratation', 4 FROM DUAL UNION ALL
SELECT 33, 33, N'Lights', N'Luz', N'�clairage', 4 FROM DUAL UNION ALL
SELECT 34, 34, N'Locks', N'Candado', N'Antivol', 4 FROM DUAL UNION ALL
SELECT 35, 35, N'Panniers', N'Cesta', N'Sacoche', 4 FROM DUAL UNION ALL
SELECT 36, 36, N'Pumps', N'Bomba', N'Pompe', 4 FROM DUAL UNION ALL
SELECT 37, 37, N'Tires and Tubes', N'Cubierta y c�mara', N'Pneu et chambre � air', 4 FROM DUAL;

COMMIT;

