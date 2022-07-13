#!/usr/bin/env fish

set -g filters /tmp/rclone-filters.txt

for save_path in (fd -H -p 'steam_autocloud\.vdf$' $HOME)
    echo "+ $(string replace $HOME '' (path dirname $save_path))/**"
end > $filters

for save_path in '.local/share/Steam/steamapps/common/Subnautica/SNAppData/**' '.var/app/org.polymc.PolyMC/data/PolyMC/instances/**' '.local/share/Steam/userdata/**/screenshots/*.jpg'
    echo "+ /$save_path"
end >> $filters

echo '- **' >> $filters

echo "Generated $(cat $filters | wc -l) filter instructions"

rclone sync \
    --fast-list \
    --no-update-modtime \
    --skip-links \
    --filter-from $filters \
    $HOME b2:Phoenix-Files/saves/steamdeck
