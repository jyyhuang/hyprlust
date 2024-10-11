# Hyprdots


## Generate packages
pacman -Qqe | grep -vx "$(pacman -Qqm)" > pkglist.txt
pacman -Qqm > aurlist.txt
