#!/sbin/sh
#
# Backkup all files from Mako Tools
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/com.asksven.betterbatterystats_xdaedition.apk
system/app/Toggle2G/Toggle2G.apk
system/etc/hosts
system/etc/init.d/01kernel
system/etc/init.d/02sound
system/media/bootanimation.zip
system/vendor/egl/eglsubAndroid.so
system/vendor/egl/libEGL_adreno.so
system/vendor/egl/libGLESv1_CM_adreno.so
system/vendor/egl/libGLESv2_adreno.so
system/vendor/egl/libq3dtools_adreno.so
system/vendor/lib/libadreno_utils.so
system/vendor/lib/libbccQTI.so
system/vendor/lib/libC2D2.so
system/vendor/lib/libc2d30-a3xx.so
system/vendor/lib/libCB.so
system/vendor/lib/libgsl.so
system/vendor/lib/libllvm-qcom.so
system/vendor/lib/librs_adreno.so
system/vendor/lib/librs_adreno_sha1.so
system/vendor/lib/libRSDriver_adreno.so
system/vendor/lib/libsc-a3xx.so
system/xbin/fixsdcard
system/xbin/fstrimall
system/xbin/maintenance
system/xbin/mako-tools
system/xbin/sqlite3
system/xbin/vacuum
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
