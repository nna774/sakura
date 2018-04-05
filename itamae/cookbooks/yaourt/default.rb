execute "makepkg package-query" do
  command "rm -rf /tmp/package-query; \
           mkdir /tmp/package-query; \
           cd /tmp/package-query; \
           wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=package-query -O PKGBUILD; \
           makepkg -s"
  not_if "pacman -Q package-query"
  cwd "/tmp/"
  user "nona" # u-n
end

packs = Dir.glob('/tmp/package-query/*.pkg.tar.xz')

execute "install package-query" do
  command "pacman -U #{packs.length == 1 ? packs[0] : fail} --noconfirm"
  not_if "pacman -Q package-query"
end

execute "makepkg yaourt" do
  command "rm -rf /tmp/yaourt; \
           mkdir /tmp/yaourt; \
           cd /tmp/yaourt; \
           wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yaourt -O PKGBUILD; \
           makepkg -s"
  not_if "pacman -Q yaourt"
  cwd "/tmp/"
  user "nona" # u-n
end

packs = Dir.glob('/tmp/yaourt/*.pkg.tar.xz')

execute "install yaourt" do
  command "pacman -U #{packs.length == 1 ? packs[0] : fail} --noconfirm"
  not_if "pacman -Q yaourt"
end
