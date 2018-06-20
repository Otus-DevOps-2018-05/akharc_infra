# akharc_infra
akharc Infra repository
bastion_IP = 35.228.218.59
someinternalhost_IP = 10.166.0.3
ssh -i ~/.ssh/appuser -A -t appuser@35.228.218.59 ssh -t 10.166.0.3

Additional task, HW3:
echo "alias someinternalhost='ssh -i ~/.ssh/appuser -A -t appuser@35.228.218.59 ssh -t 10.166.0.3'" >> ~/.bashrc