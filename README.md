# Implementación de microservicios

## Docker

### Estructura


El despliegue de docker-compose se puede apreciar en el siguiente diagrama:

![Diagrama de despliegue de docker](/images/docker-compose.png?raw=true)

Todos los servicios son accedidos a través de [Caddy](https://github.com/caddyserver/caddy), que actúa de proxy inverso para los diferentes microservicios en el puerto `80`.

Además se unifica el root del api a `/api/v1/`, reescribiendo las rutas para que cada microservicio pueda procesar las peticiones de acuerdo a su propia estructura interna.

Los servicios que así lo requieren disponen de un contenedor extra para mantener los datos. Se consigue la persistencia a través de la creación de _volumes_ en el host. En el caso de algún servicio que ha requerido un archivo de configuración o inicialización, este le ha sido provisto a través de un _mount_ con un _volume_.

Para aislar el tráfico dentro del despliegue se han definido 6 redes, una por microservicio. Estas redes sirven para comunicarse con sus respectivas bases de datos si las hubiera y para el acceso del proxy inverso al endpoint de cada uno.

### Instalación
<<<<<<< HEAD

> :warning: **Uso elevado de memoria**: Debido a la gran cantidad de contenedores, se recomienda tener al menos `3GB` libres de RAM para el despliegue del servicio.

=======
>>>>>>> main

Para desplegar los contenedores de Docker-compose ejecutar en el directorio `compose`

```bash
docker compose up
```
 o lo que es lo mismo

 ```bash
cd compose
docker compose up
```

### Uso

Una vez iniciados todos los servicios se podrá acceder a través de la dirección del host en el puerto 80 al endpoint del API, situado en `/api/v1/`.

#### Ejemplo:

```bash
curl --request GET \
  --url http://localhost/api/v1/notificacion \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json'
```


#### Lista de Endpoints disponibles

-  `http://localhost/api/v1/clientes`
-  `http://localhost/api/v1/vehiculos`
-  `http://localhost/api/v1/jobs`
-  `http://localhost/api/v1/notificacion`
-  `http://localhost/api/v1/factura`
-  `http://localhost/api/v1/recambios`

## Kubernetes

### Estructura

El despliegue de kubernetes se puede apreciar en el siguiente diagrama:

![Diagrama de despliegue de kubernetes](/images/kube.png?raw=true)

Todos los servicios son accedidos a través del Ingress, que actúa tanto de proxy inverso como de load balancer para los diferentes microservicios.

Además se unifica el root del api a `/api/v1/`, reescribiendo las rutas para que cada microservicio pueda procesar las peticiones de acuerdo a su propia estructura interna.

Los servicios que así lo requieren disponen de un servicio StateFull para mantener los datos. Se Consigue la persistencia a través de la creación de objetos PersistentVolumes. En el caso de algún servicio que ha requerido un archivo de configuración o inicialización, este le ha sido provisto a través de un ConfigMap.

En la configuración que se proporciona todos los servicios contienen una única réplica para facilitar el despliegue.

Debido a que se desconoce la implementación de muchos de los servicios no se han aplicado restricciones de recursos a excepción de un límite de almacenamiento en los PersistentVolumes.


### Instalación

> :warning: **Uso elevado de memoria**: Debido a la gran cantidad de contenedores, se recomienda tener al menos `3GB` libres de RAM para el despliegue del servicio.

Para el despliegue del cluster de kubernetes hay que seguir los siguientes pasos:

1. Instalar Nginx Ingress Controller
   
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/cloud/deploy.yaml
    ```
2. Mientras se levanta el servicio, cambiar al directorio `kubernetes`

    ```bash
    cd kubernetes
    ```
3. Tras haber esperado unos 20 segundos a la inicialización del ingress controller aplicar todos las definiciones de objetos presentes en la carpeta.
    ```bash
    kubectl apply -f .
    ```

### Uso

Una vez iniciados todos los servicios se podrá acceder a través de la dirección del host en el puerto 80 al endpoint del API, situado en `/api/v1/`.

Ejemplo:
```bash
curl --request GET \
  --url http://localhost/api/v1/notificacion \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json'
```

>El endpoint `/api/v1/vehiculo` no funciona debido a un error en la configuración del contenedor del subsistema 2. Se hace uso del carácter ilegal ( `_` ) en el nombre de host (`mysql_subsistema2`) para el acceso a la base de datos, imposibilitando la creación de este nombre y consecuentemente la conexión. Más información en el [RFC952](http://www.faqs.org/rfcs/rfc952.html)

#### Lista de Endpoints disponibles

-  `http://localhost/api/v1/clientes`
-  ~~`http://localhost/api/v1/vehiculo`~~ No funcional
-  `http://localhost/api/v1/jobs`
-  `http://localhost/api/v1/notificacion`
-  `http://localhost/api/v1/factura`
-  `http://localhost/api/v1/recambios`

## Despliegue 

Se encuentra en el archivo [cloud.md](/cloud.md) 