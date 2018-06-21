# akharc_infra
akharc Infra repository
bastion_IP = 35.228.218.59
someinternalhost_IP = 10.166.0.3
ssh -i ~/.ssh/appuser -A -t appuser@35.228.218.59 ssh -t 10.166.0.3
Additional task, HW3:
echo "alias someinternalhost='ssh -i ~/.ssh/appuser -A -t appuser@35.228.218.59 ssh -t 10.166.0.3'" >> ~/.bashrc
# Homework 4
testapp_IP = 35.228.196.231
testapp_port = 9292
## Additional task 1 - add startup script
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=install.sh
## Additional task 2  - add firewall rule
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server
