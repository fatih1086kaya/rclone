index=75
deneme=0
while :
do
deneme=$(($deneme + 1))
echo -e "\e[3;31m Deneme: $deneme \e[0m"
echo ""
sayi=0
sayi=($(ls /ssd2/*.plot | wc -l))
echo -e "\e[3;36m Plot Sayisi: $sayi \e[0m"
echo -e "\e[3;36m Service Account: $index \e[0m"
echo " "
if [[ $sayi -gt 0 ]]; then
index=$index
if [[ $index -gt 200 ]]; then
index=1
fi
echo -e "\e[3;32m Plot Transferi Baslatiliyor ... \e[0m"
#rclone copy --fast-list --ignore-existing /ssd2/ drop:yedek/  --transfers=15 --drive-server-side-across-configs  -P -c -v --include "/*.plot"
rclone move /ssd2/ sogukdepo1:azur/ --drive-service-account-file=/root/.config/rclone/accounts/"$((1 + $RANDOM % 200)).json" --drive-chunk-size 1024M --no-traverse --min-size 101G --checkers 3 --tpslimit 3 --transfers 3 --fast-list --drive-server-side-across-configs -P --drive-stop-on-upload-limit;
index=$(($index + 1))
echo -e "\e[3;32m Program Döngüsü Bitti ... \e[0m"
echo "********************************************************"
sleep 5
fi
sleep 10
done
