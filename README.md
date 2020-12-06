# Obligatorio-ISC

# efs.tf

Contiene todo lo necesario para crear un EFS y poder montarlo en una instancia EC2.

-----------------------------------------
# ins.tf

Crea un instancia de EC2 que se utilizará para tareas de mantenimiento y manejo de backups.

-----------------------------------------
# networking.tf

Crea todos los recursos de red necesarios para la implementación.

-----------------------------------------
# providers.tf

Contiene las configuraciones del provider que se va a utilizar.

-----------------------------------------
# s3.tf

Contiene todo lo necesario para crear un bucket S3 y poder consumirlo desde instancia EC2.

-----------------------------------------
# svc_db

Crea una instancia de RDS y su correspondiente subnet group.

-----------------------------------------
# svc_web.tf

Crea un ELB y un ASG apartir de un lauch configuration. Este último cuenta con lo necesario para levantar un applicacción Web en php y consumir una base de datos MySQL

-----------------------------------------
# vars.tf

Contiene las variables con las que se parametrizaron todos los archivos ".tf" anteriores, así como también la variables de salida.

-----------------------------------------
