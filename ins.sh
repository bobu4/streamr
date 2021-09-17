#!/bin/sh
sudo tee <<EOF >/dev/null /root/str.sh
#!/bin/bash
wallet_address=$(docker logs streamr_1 | grep -oPm1 "(?<=Network node 'miner-node' \(id\=)([^%]+)(?=\) running)")
wallet_info=$(wget -qO- "https://testnet1.streamr.network:3013/stats/$wallet_address")
balance=$(jq ".claimCount" <<< $wallet_info)
balance_percentage=$(jq ".claimPercentage" <<< $wallet_info)
printf '{"wallet_address":"%s","balance":%d,"balance_percentage":%f}\n' "$wallet_address" "$balance" "$balance_percentage"
EOF
chmod +x str.sh
sudo tee <<EOF >/dev/null /root/str1.sh
#!/bin/bash
wallet_address=$(docker logs streamr_2 | grep -oPm1 "(?<=Network node 'miner-node' \(id\=)([^%]+)(?=\) running)")
wallet_info=$(wget -qO- "https://testnet1.streamr.network:3013/stats/$wallet_address")
balance=$(jq ".claimCount" <<< $wallet_info)
balance_percentage=$(jq ".claimPercentage" <<< $wallet_info)
printf '{"wallet_address":"%s","balance":%d,"balance_percentage":%f}\n' "$wallet_address" "$balance" "$balance_percentage"
EOF
chmod +x str1.sh
