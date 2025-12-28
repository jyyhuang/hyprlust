#!/usr/bin/env bash

set -euo pipefail

CURSOR_DIR="${1:-$HOME/.local/share/icons/Miku_1/cursors}"

if [[ ! -d "$CURSOR_DIR" ]]; then
  echo "Cursor directory not found: $CURSOR_DIR"
  exit 1
fi

cd "$CURSOR_DIR"

declare -A MAP=(
  [Alternate]="bottom_left_corner bottom_right_corner bottom_side down-arrow left-arrow left_side right-arrow right_side top_left_corner top_right_corner top_side up_arrow"
  [Busy]="half-busy wait watch"
  [Precision]="cross crosshair"
  [Normal]="arrow default left_ptr size-bdiag size-fdiag size-hor size-ver top_left_arrow"
  [Diagonal1]="nw-resize nwse-resize se-resize size_fdiag"
  [Diagonal2]="ne-resize nesw-resize sw-resize size_bdiag"
  [Handwriting]="draft pencil"
  [Help]="help left_ptr_help question_arrow whats_this"
  [Horizontal]="col-resize e-resize ew-resize h_double_arrow sb_h_double_arrow size_hor split_h w-resize"
  [Link]="grab hand hand1 hand2 openhand pointer pointing_hand"
  [Move]="all-scroll closedhand dnd-move dnd-none fleur grabbing move size_all"
  [Text]="ibeam text xterm"
  [Unavailable]="circle crossed_circle dnd_no_drop forbidden no_drop not_allowed"
  [Vertical]="n-resize ns-resize row-resize s-resize sb_v_double_arrow size_ver split_v v_double_arrow"
  [Working]="left_ptr_watch pirate progress"
)

echo "Mapping cursors in: $CURSOR_DIR"
echo

for src in "${!MAP[@]}"; do
  if [[ ! -e "$src" ]]; then
    echo "⚠️  Source cursor missing: $src (skipping)"
    continue
  fi

  for name in ${MAP[$src]}; do
    ln -sf "$src" "$name"
    echo "  $name -> $src"
  done
done

echo
echo "Cursor mapping complete"
