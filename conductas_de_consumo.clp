;; Se define estado inicial del cliente
(deftemplate cliente (slot cliente-id) (slot nombre) (slot correo) (slot cel))

;; Se define estado inicial del producto
(deftemplate producto (slot marca) (slot modelo) (slot memoria) (slot precio) (slot existencia))

;; Se integran los clientes de base de conocimientos
(defrule agregar-cliente (not (cliente (cliente-id ?))) => (assert (cliente (cliente-id 1) (nombre "Juan Perez") (correo "juanperez@gmail.com") (cel "5544332211"))) (assert (cliente (cliente-id 2) (nombre "Maria Garcia") (correo "mariagarcia@hotmail.com") (cel "5555667788"))) (assert (cliente (cliente-id 3) (nombre "Pedro Lopez") (correo "pedrolopez@yahoo.com") (cel "5566778899"))))

;; Se integran los productos de la base de conocimiento
(defrule agregar-productos (not (producto (marca ?))) => (assert (producto (marca "Apple") (modelo "Watch Series 6") (memoria 32) (precio 7999.99) (existencia 10))) (assert (producto (marca "Samsung") (modelo "Galaxy S21") (memoria 128) (precio 13999.99) (existencia 5))) (assert (producto (marca "Huawei") (modelo "MatePad Pro") (memoria 256) (precio 10999.99) (existencia 8))) (assert (producto (marca "American Express") (modelo "Tarjeta de Crédito") (memoria 0) (precio 0) (existencia 100))))

;; Se define estado inicial de las tarjetas
(deftemplate tarjeta (slot nombre (type STRING)) (slot tasa (type FLOAT)) (slot limite (type FLOAT)))

;; Se integran las tarjetas existentes
(defrule agregar-tarjetas (not (tarjeta (nombre ?))) => (assert (tarjeta (nombre "Banamex") (tasa 20.0) (limite 50000.0))) (assert (tarjeta (nombre "BBVA") (tasa 18.0) (limite 70000.0))) (assert (tarjeta (nombre "American Express") (tasa 25.0) (limite 100000.0))))

;; Se define estado inicial de las tarjetas
(deftemplate oferta (slot modelo) (slot nombre) (slot descripcion))

;; Se integran las ofertas existentes
(defrule agregar-ofertas (not (oferta (descripcion ?))) => (assert (oferta (modelo "Watch Series 6") (nombre "Banamex") (descripcion "24 meses sin intereses"))) (assert (oferta (modelo "MatePad Pro") (nombre "American Express")  (descripcion "15% de descuento"))) (assert (oferta (modelo "Galaxy S21") (nombre "BBVA")  (descripcion "12 meses sin intereses"))))

(deftemplate compra (slot modelo) (slot nombre) (slot cliente-id) (slot cantidad))


(defrule validar-compra
  (compra (modelo ?modelo)
  (nombre $? ?nombre $?)
  (cliente-id $? ?cliente-id $?)
  (cantidad$? ?cantidad $?)
  (oferta (modelo ?modelo) (nombre ?nombre) (descripcion ?descrip))
  =>
(printout t ?descrip crlf)
  (assert (producto (modelo ?modelo) (existencia ?cantidad))))

(reset)
(run)