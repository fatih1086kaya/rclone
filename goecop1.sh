index=1
account=1
cat_kontrol=0
while :
do
sayi=0
sayi=($(ls /data2/plor1/*.plot | wc -l))
KT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
echo -e "\e[3;36m Plot Sayisi: $sayi \e[0m"
if [[ $sayi -gt 0 ]]; then
   echo -e "\e[3;32m Aktarma Kotasi Kontrol Ediliyor ... \e[0m"
   echo "CATCONTROLDE"
   rclone delete henry$account:deneme/deneme.txt
   output=$(rclone copy /root/deneme.txt henry$account:deneme --drive-service-account-file=/root/.config/rclone/henry/$index.json --retries 1 2>&1)
   if [[ $output == *"Error 403: The user's Drive storage quota has been exceeded"* ]]; then
      echo "Depolama kotasi asildi!"
      echo "----------------------------------------------------------------------------------"
      cat_kontrol=0
   elif [[ $output == *"directory not found"* ]]; then
      echo "Alan bulunamadi!"
      echo "----------------------------------------------------------------------------------"
      cat_kontrol=0
   elif [[ $output == *"Error 403: User rate limit exceeded., userRateLimitExceeded"* ]]; then
      echo "Rate Limit Exceed!"
      echo "----------------------------------------------------------------------------------"
      cat_kontrol=0
   elif [[ $output == *"file not found"* ]]; then
      echo "Alan bulunamadi2!"
      echo "----------------------------------------------------------------------------------"
      cat_kontrol=0
   elif [[ $output == *"create file system for"* ]]; then
      echo "create file system!"
      echo "----------------------------------------------------------------------------------"
      cat_kontrol=0
   else
      echo "Tasima islemi tamamlandi."
      echo "$output"
      cat_kontrol=1
   fi
   rclone delete henry$account:deneme/deneme.txt
   echo "-----henry-------$account----e-----gecildi----ust----"
   echo "Dosya Atilabilir mi response: $cat_kontrol"
   if (( cat_kontrol == 1 )); then
      echo "dosya atılabilir"
          echo -e "\e[3;32m Aktarma Baslatiliyor ... \e[0m"
      index=$((1 + $RANDOM % 800))
      rclone move /data2/plor1/ cript$account: --drive-service-account-file=/root/.config/rclone/henry/"$index.json" --drive-server-side-across-configs --user-agent="${KT}" --drive-chunk-size=2G --drive-upload-cutoff=1000T --drive-stop-on-upload-limit --retries=1 --checkers=3 --tpslimit=3 --transfers=6 -P
      account=$((1 + $RANDOM % 50))
   else
      echo "Dosya tasinamamis yeni folder a gec"
      account=$((1 + $RANDOM % 50))
   fi
   echo "-----henry-------$account----e-----gecildi----alt----"
   echo -e "\e[3;32m Program Dongusu Bitti ... \e[0m"
   echo "************************************************************************************"
fi
   index=$index
   sleep 5
done
