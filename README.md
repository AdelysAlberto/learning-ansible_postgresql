```markdown
# 🐘 Ansible PostgreSQL + NFS Backup Automation

Este proyecto utiliza **Ansible** para automatizar la configuración de:

- Un servidor **PostgreSQL**
- Un servidor **NFS** para almacenar backups
- Un sistema de backups automáticos y programados

## 📌 Requisitos

- Ansible instalado en tu máquina local (`pip install ansible`)
- Dos máquinas virtuales accesibles por SSH:
  - PostgreSQL Server (ej. 192.168.56.10)
  - NFS Server (ej. 192.168.56.11)
- Clave SSH configurada para acceso sin contraseña

## 📁 Estructura del proyecto

```

.
├── backup\_postgresql.yml         # Playbook principal
├── inventory.yml                 # Inventario de hosts
├── vars/
│   └── main.yml                  # Variables (opcional si no están en el inventario)
├── templates/
│   └── exports.j2                # Configuración NFS (/etc/exports)
├── files/
│   └── backup.sh                 # Script de backup
└── README.md

````

## ⚙️ Configuración del inventario

Edita `inventory.yml` para configurar las IPs de tus máquinas:

```yaml
all:
  vars:
    nfs_directory: /srv/backups
    mount_point: /mnt/backups
    db_name: mi_base_de_datos
    db_user: postgres
    nfs_server_ip: 192.168.56.11
  children:
    postgres:
      hosts:
        postgres_server:
          ansible_host: 192.168.56.10
          ansible_user: ubuntu
    nfs:
      hosts:
        nfs_server:
          ansible_host: 192.168.56.11
          ansible_user: ubuntu
````

## 🚀 Ejecución del Playbook

```bash
ansible-playbook -i inventory.yml backup_postgresql.yml
```

Este comando ejecutará la automatización completa:

* Instalará PostgreSQL
* Creará una base de datos
* Configurará NFS
* Montará el volumen compartido
* Copiará el script de backup
* Programará un cron diario a las 2 AM

## 🔄 Verificación

* En el servidor PostgreSQL:

  ```bash
  ls /mnt/backups
  ```

* En el servidor NFS:

  ```bash
  ls /srv/backups
  ```

* Comprobar tarea cron:

  ```bash
  crontab -l
  ```

## 📋 Notas

* El script de backup se ejecuta como el usuario `postgres` y guarda los archivos `.sql` con timestamps en el directorio NFS.
* Puedes cambiar el horario del cron o la política de retención de backups según tus necesidades.

## 🧑‍💻 Autor

Desarrollado por Adelys Belén – [@AdelysAlberto](https://github.com/AdelysAlberrto)
---
