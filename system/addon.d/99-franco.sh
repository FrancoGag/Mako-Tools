#!/sbin/sh
#
# Backkup all files from Mako Tools
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/com.asksven.betterbatterystats_xdaedition.apk
addon.d/75-xposed.sh
addon.d/99-franco.sh
app/Toggle2G/Toggle2G.apk
etc/hosts
etc/init.d/01kernel
etc/init.d/02sound
media/bootanimation.zip
xbin/fixsdcard
xbin/fstrimall
xbin/maintenance
xbin/makotools
xbin/sqlite3
xbin/vacuum
EOF
}
case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    sed -i '/wifi.supplicant_scan_interval/c\wifi.supplicant_scan_interval=120' /system/build.prop
    sed -i '/ro.config.vc_music_vol_steps/c\ro.config.vc_music_vol_steps=15' /system/build.prop
    rm -rf /system/app/Stk/
    rm -rf /system/app/Calculator/
    rm -rf /system/app/LockClock/
    rm -rf /system/priv-app/HotwordEnrollment/
    rm -rf /system/priv-app/Velvet/
  ;;
esac
