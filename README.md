# akharc_infra
akharc Infra repository
bastion_IP = 35.228.218.59
someinternalhost_IP = 10.166.0.3
```
ssh -i ~/.ssh/appuser -A -t appuser@35.228.218.59 ssh -t 10.166.0.3
```
Additional task, HW3:
```
echo "alias someinternalhost='ssh -i ~/.ssh/appuser -A -t appuser@35.228.218.59 ssh -t 10.166.0.3'" >> ~/.bashrc
```
# Homework 4
testapp_IP = 35.228.196.231
testapp_port = 9292
## Additional task 1 - add startup script
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=install.sh
```
## Additional task 2  - add firewall rule
```
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server
```
# Homework 5
Added packer dir with packer template and variable files, created image with Ruby and Mongo in GCP for deploy reddit app

# Homework 6
Общее задание: установлен Terraform создано описание инфраструктуры базового проэкта с помощью файлов main.tf, terraform.tfvars и variables.tf
Задание со *: Ключи для нескольки пользователей добавлены в метадату проэкта следующим образом:
```
resource "google_compute_project_metadata" "app" {
  metadata {
      ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
      #    appuser2:${file(var.public_key_path)}"
      
        }
        }
        
```
Иные ключи, присутствующие в метаданных, но не описанных с помощью terraform после terraform apply из метаданных удаляются.
# Homework 7
Общее задание: Вместо общего main.tf конфигурация разбита на модули, описаны Stage и Prod, созданы бакеты
Задание со *: Настроено удаленное хранение state-Файлов в бэкенде gcs. При одновременном применении появляется сообщение:
```
Error: Error locking state: Error acquiring the state lock: writing "gs://storage-bucket-akha/terraform/state/prod/default.tflock" failed: googleapi: Error 412: Precondition Failed, conditionNotMet
        
```
# Homework 8

Установлена система управления конфигурацией Ansible, созданы файлы inventory в различных форматах, создан файл конфигурации, опробована работ ansible напрямую из командной строки и через простой плейбук.

Общее задание:
Первое применение плейбука clone.yml не внесло изменеий в соответсвтии с принципом идемпотентности, т.к. каталог /home/appuser/reddit был ранее создан с помощью команды 

```
ansible app -m command -a 'git clone https://github.com/express42/reddit.git /home/appuser/reddit' 
```
После удаления описанного каталога в результате  запускп плейбука на удаленном хосте произошло  применнение изменений.

Заднаие со *:
 Создан файл инвентори в формате json, создан скрипт, кторый передает содержание инветори в ansible:
```
ansible all -m ping -i inventory.sh

```
# Homework 9 
Общее задание:
Подготовлены общие  плейбуков для настройки инстансов с mongodb и приложением
Общий плейбук разбит на несколько вложенных
Написаны плейбуки для провиженига с помощью Packer

#Homework 10

Общее задание:
Плеуйбуки app и db реорганизованы в роли, структура каталогов ролей организована с помощью ansible-galaxy
Созданы окружения stage и prod, по умолчанию в конфигурации ansible.cfg указано обращение к инвентори-файлу окружения Stage
структура каталогов приведена в соответствие с Best practices
Для настройки stage-окружения использована комьюнити-роль jdauphant.nginx
Подготовлен плейбук для создания пользователей, использующий зашифрованные данные с помощью ansible-vault

#Homework 11

Общее задание:
Установлен и настроен Vagrant

Первое задание со *
В vagrantfile внесены изменения для того, чтобы nginx слушал 80 порт
```
        "nginx_sites": {
          "default": [
            "listen 80",
            "server_name appserver",
            "location / {
              proxy_pass http://0.0.0.0:9292;
            }"]
        }
```
Установлена и настроена molecule, протестирована роль db
Написан тест для проверки доступности порта mongodb
```
#chek if mongo is binded to 27017
def test_mongo_socket(host):
    host.socket("tcp://0.0.0.0:27017").is_listening
```
Настроена сборка шаблонов packer при помощи ролей

```
bash-4.2# packer validate -var-file=packer/variables.json  packer/app.json
Template validated successfully.
bash-4.2# packer validate -var-file=packer/variables.json  packer/db.json
Template validated successfully.
```
