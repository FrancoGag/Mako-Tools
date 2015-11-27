#!/sbin/sh
#
# Backkup xposed after a dirty flash
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
bin/app_process32_xposed
bin/dex2oat
bin/oatdump
bin/patchoat
framework/XposedBridge.jar
lib/libart-compiler.so
lib/libart-disassembler.so
lib/libart.so
lib/libsigchain.so
lib/libxposed_art.so
xposed.prop
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
    # Stub
  ;;
esac
