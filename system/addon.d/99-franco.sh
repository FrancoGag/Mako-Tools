#!/sbin/sh
#
# Backkup all files from Mako Tools
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/com.asksven.betterbatterystats_xdaedition.apk
app/Toggle2G/Toggle2G.apk
etc/hosts
etc/init.d/01kernel
etc/init.d/02sound
media/bootanimation.zip
vendor/egl/eglsubAndroid.so
vendor/egl/libEGL_adreno.so
vendor/egl/libGLESv1_CM_adreno.so
vendor/egl/libGLESv2_adreno.so
vendor/egl/libq3dtools_adreno.so
vendor/lib/libadreno_utils.so
vendor/lib/libbccQTI.so
vendor/lib/libC2D2.so
vendor/lib/libc2d30-a3xx.so
vendor/lib/libCB.so
vendor/lib/libgsl.so
vendor/lib/libllvm-qcom.so
vendor/lib/librs_adreno.so
vendor/lib/librs_adreno_sha1.so
vendor/lib/libRSDriver_adreno.so
vendor/lib/libsc-a3xx.so
xbin/fixsdcard
xbin/fstrimall
xbin/maintenance
xbin/mako-tools
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
   rm -rf /system/priv-app/Velvet/
  ;;
esac
