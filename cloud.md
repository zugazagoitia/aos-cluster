# Despliegue en Nube Pública

## Docker

Para el despliegue de docker-compose se ha usado una VM-B1S de Azure. 

Se han seguido los siguientes pasos:

- Instalar la imagen de Debian 9 en la VM 
- Conectándose por SSH, instalar la última versión de docker
- Descargar el repositorio desde git y
- Ejecutar `docker compose up` sobre la carpeta `compose`

![Figura 1](/images/cloud0.png?raw=true)

![Figura 2](/images/cloud1.png?raw=true)

![Figura 3](/images/cloud2.png?raw=true)

Una vez ejecutado, podemos acceder al API a través de la IP pública que nos proporciona azure.

![Figura 4](/images/cloud3.png?raw=true)


## Kubernetes


Para el despliegue del cluster de Kubernetes se ha usado un Azure Kubernetes Service. 

![Figura 5](/images/cloud4.png?raw=true)

Se han seguido los siguientes pasos:

1. Crear el AKS 
2. Conectándose por la azure shell, descargar el repositorio desde git
3. Connectar la shell al cluster de kubernetes creado
4. Instalar Nginx Ingress
![Figura 6](/images/cloud5.png?raw=true)

5. Ejecutar `kubectl apply -f .` sobre la carpeta `kubernetes`
6. Extraer la ip pública proporcionada por azure
![Figura 7](/images/cloud6.png?raw=true)

Una vez completados los anteriores pasos nos podemos conectar a la IP proporcionada para comprobar el funcionamiento del API.

![Figura 8](/images/cloud7.png?raw=true)
