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
