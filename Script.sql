-- Parte 5: Agregar restricciones de llave foránea

-- Producto -> Categoria
ALTER TABLE Producto
ADD FOREIGN KEY (categoria_id) REFERENCES Categoria(id);

-- Stock -> Sucursal & Producto
ALTER TABLE Stock
ADD FOREIGN KEY (Sucursal_Id) REFERENCES Sucursal(id),
ADD FOREIGN KEY (Producto_Id) REFERENCES Producto(id);

-- Orden -> Cliente & Sucursal
ALTER TABLE Orden
ADD FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
ADD FOREIGN KEY (sucursal_id) REFERENCES Sucursal(id);

-- Item -> Orden & Producto
ALTER TABLE Item
ADD FOREIGN KEY (orden_id) REFERENCES Orden(id),
ADD FOREIGN KEY (producto_id) REFERENCES Producto(id);

-- Parte 6: Realizar consultas analíticas

-- Calcular el precio promedio de los productos en cada categoría
SELECT 
    c.nombre AS Categoria, 
    AVG(p.precio_unitario) AS Precio_Promedio
FROM Producto p
JOIN Categoria c ON p.categoria_id = c.id
GROUP BY c.nombre;

-- Obtener la cantidad total de productos en stock por categoría
SELECT 
    c.nombre AS Categoria, 
    SUM(s.Cantidad) AS Total_Productos
FROM Stock s
JOIN Producto p ON s.Producto_Id = p.id
JOIN Categoria c ON p.categoria_id = c.id
GROUP BY c.nombre;

-- Calcular el total de ventas por sucursal
SELECT 
    s.nombre AS Sucursal, 
    SUM(o.total) AS Total_Ventas
FROM Orden o
JOIN Sucursal s ON o.sucursal_id = s.id
GROUP BY s.nombre;

-- Obtener el cliente que ha realizado el mayor monto de compras
SELECT 
    c.nombre AS Cliente, 
    SUM(o.total) AS Monto_Total
FROM Orden o
JOIN Cliente c ON o.cliente_id = c.id
GROUP BY c.nombre
ORDER BY Monto_Total DESC
LIMIT 1;