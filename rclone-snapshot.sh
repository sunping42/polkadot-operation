read -p "Chain(polkadot/kusama/paseo): " chain
if [[ "$chain" == "kusama" ]]; then
  chainid="ksmcc3"
else
  chainid=$chain
fi
read -p "Database(rocksdb/paritydb): " database

PATH_TO_DB_FOLDER="/home/polkadot/.local/share/polkadot/chains/$chainid/db"

if [ -d "$PATH_TO_DB_FOLDER/full" ]; then
  echo "Database directory $PATH_TO_DB_FOLDER is not empty."
  # exit 1
fi

SNAPSHOT_URL=`curl -s https://snapshots.polkadot.io | grep -oP "https://snapshots.polkadot.io/$chain-$database-prune/[^\"<]+"`

echo "SNAPSHOT_URL: $SNAPSHOT_URL"
echo "PATH_TO_DB_FOLDER: $PATH_TO_DB_FOLDER"
read -p "Press any key to continue"

rclone copyurl $SNAPSHOT_URL/files.txt files.txt
rclone copy --progress --transfers 20 --http-url $SNAPSHOT_URL --no-traverse --http-no-head --disable-http2 --inplace --no-gzip-encoding --size-only --retries 6 --retries-sleep 10s --files-from files.txt :http: $PATH_TO_DB_FOLDER
rm files.txt

chown -R polkadot:polkadot $PATH_TO_DB_FOLDER
