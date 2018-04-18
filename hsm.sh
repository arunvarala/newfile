#!/bin/bash
cd /nfs/common/sds/BlackVault/
#Varibale declartion
read -p "Enter key Name: "                               key
read -p "Enter Key Type: "                               type_key
read -p "Enter The Key Size: "                           size_key
read -p "Enter Mechanism Type: "                         mechanism
read -p "Enter Server Name: "                            server
read -p "Enter the Days the cert should active : "       days
#read -p "Do you want to encrupt the key type (Yes/No) " yn
#read -p "Enter encrypt filename: "                       encryptfilename

#BlackVault-HSM installation.
STEP="-----installing BV-HSM"
echo $STEP
if [ `uname -m` = "x86_64" ]; then
   export OPT_ARCH=x86_64 && rpm -ivh bvhsm-7.0.17.1-1.x86_64.rpm
else
   if [ `uname -m` = "amd64" ]; then
   export OPT_ARCH=amd64 && rpm -ivh bvhsm_7.0.17.1-1_amd64.deb
else
   export OPT_ARCH=unknown
fi
echo "OPT_ARCH is $OPT_ARCH"

#Go to the directory where you want to get all keys and certificates. 
cd /home/

#When BV-HSM is installed it creates BV_Client_Cert file in /etc/ssl/certs/
if [ ! -f /etc/ssl/certs/BV_Client_Cert.pem ]; then
    echo "File not found!"
else
        export BV_PKCS_PATH=/nfs/common/sds/BlackVault/Configuration/pkcs.dat
    sudo yum install net-tools
    sudo ifconfig eno1 10.0.0.2 netmask 255.255.255.0 up

STEP="-----Creating key"
echo $STEP
#create key
    bvtool genkey -l $key --type $type_key --size $size_key

#list keys
    serialnumber = $(bvtool list -a | grep "$key" | grep -o "6.*") |head -n 1

STEP="-----creating CSR"
echo $STEP
#create csr
    bvtool gencsr -l $key -m $mechanism --country US --state MA --locality lowell --organization cspi --common $server -o csr.pem

STEP="-----creating self-signed certificate"
echo $STEP
#create self-signed certificate
    bvtool gensscert -l $key -m $mechanism --country US --state MA --locality lowell --organization cspi --common $server --days $days -o self-ca.pem --serial $serialnumber

STEP="-----signing CSR to create certificate"
echo $STEP
#sign CSR to create certificate
    bvtool gencert -l $key -m $mechanism --days $days --csr csr.pem --ca self-ca.pem -o key-csr.pem --serial $serialnumber

STEP="-----signing tar file"
echo $STEP
#sign file
    bvtool sign -l $key -m $mechanism -i testtardirtarfile.tar.gz -o signed$key

STEP="-----verifying tar file"
echo $STEP
#verify file
    bvtool verify -l $key -m $mechanism -i testtardirtarfile.tar.gz -s signed$key

STEP="-----exporting key "
echo $STEP
#export publickey
    bvtool export -l $key -t $type_key -o $keypub

#encrypt
#STEP="-----encrypting file "
#echo $STEP

#while true; do
#    case $yn in
#        Yes ) bvtool encrypt -l $key -m $mechanism -i testtardirtarfile.tar.gz -o $encryptfilename; break;;
#        * ) echo "Hello" > /dev/null; break;;
#    esac
#done

#while true; do
#    case $mechanism in
#        rsa ) bvtool export -l $key -o $keypub; break;;
#        * ) echo "Hello" > /dev/null; break;;
#    esac
#done
fi

