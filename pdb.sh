#!/bin/bash

home="/home/moggles"
function build_artix_repo() {
	mkdir ${home}/Downloads/$1
	pushd ${home}/Downloads/$1
		wget $2/$1.db.tar.xz
		tar xf $1.db.tar.xz
		rm $1.db.tar.xz

		for p in $(ls)
		do
			# PDN retrieves the name of the package
			pdn=$(cat $p/desc | grep -A1 "%NAME%" | sed -n 2p)
			echo "Name: $pdn" >> ${home}/Downloads/${1}/${1}_pkg.txt
	
			# PDV retrieves the version of the package
			pdv=$(cat $p/desc | grep -A1 "%VERSION%" | sed -n 2p)
			echo "Version: $pdv" >> ${home}/Downloads/${1}/${1}_pkg.txt
	
			# PDF retrieves the Download location of the package
			pdf=$(cat $p/desc | grep -A1 "%FILENAME%" | sed -n 2p)
			echo "Download: $2/$pdf" >> ${home}/Downloads/${1}/${1}_pkg.txt
			echo "" >> ${home}/Downloads/${1}/${1}_pkg.txt
		done
	popd
}

function build_arch_repo() {
	mkdir ${home}/Downloads/$1
	pushd ${home}/Downloads/$1
		wget $2/$1.db.tar.gz
		tar xf $1.db.tar.gz
		rm $1.db.tar.gz

		for p in $(ls)
		do
			# PDN retrieves the name of the package
			pdn=$(cat $p/desc | grep -A1 "%NAME%" | sed -n 2p)
			echo "Name: $pdn" >> ${home}/Downloads/${1}/${1}_pkg.txt
	
			# PDV retrieves the version of the package
			pdv=$(cat $p/desc | grep -A1 "%VERSION%" | sed -n 2p)
			echo "Version: $pdv" >> ${home}/Downloads/${1}/${1}_pkg.txt
	
			# PDF retrieves the Download location of the package
			pdf=$(cat $p/desc | grep -A1 "%FILENAME%" | sed -n 2p)
			echo "Download: $2/$pdf" >> ${home}/Downloads/${1}/${1}_pkg.txt
			echo "" >> ${home}/Downloads/${1}/${1}_pkg.txt
		done
	popd
}

build_artix_repo "gremlins" "https://mirrors.dotsrc.org/artix-linux/repos/gremlins/os/x86_64"
build_artix_repo "system" "https://mirrors.dotsrc.org/artix-linux/repos/system/os/x86_64"
build_artix_repo "world" "https://mirrors.dotsrc.org/artix-linux/repos/world/os/x86_64"
build_artix_repo "galaxy-gremlins" "https://mirrors.dotsrc.org/artix-linux/repos/galaxy-gremlins/os/x86_64"
build_artix_repo "galaxy" "https://mirrors.dotsrc.org/artix-linux/repos/galaxy/os/x86_64"
build_artix_repo "lib32" "https://mirrors.dotsrc.org/artix-linux/repos/lib32/os/x86_64"

cat ${home}/Downloads/gremlins/gremlins_pkg.txt > ${home}/Downloads/repo.list
cat ${home}/Downloads/system/system_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/world/world_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/galaxy-gremlins/galaxy-gremlins_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/galaxy/galaxy_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/lib32/lib32_pkg.txt >> ${home}/Downloads/repo.list

rm -rf ${home}/Downloads/gremlins ${home}/Downloads/system ${home}/Downloads/world ${home}/Downloads/galaxy-gremlins ${home}/Downloads/galaxy ${home}/Downloads/lib32

build_arch_repo "testing" "http://mirrors.edge.kernel.org/archlinux/testing/os/x86_64"
build_arch_repo "core" "http://mirrors.edge.kernel.org/archlinux/core/os/x86_64"
build_arch_repo "community-testing" "http://mirrors.edge.kernel.org/archlinux/community-testing/os/x86_64"
build_arch_repo "community" "http://mirrors.edge.kernel.org/archlinux/community/os/x86_64"
build_arch_repo "extra" "http://mirrors.edge.kernel.org/archlinux/extra/os/x86_64"
build_arch_repo "multilib" "http://mirrors.edge.kernel.org/archlinux/multilib/os/x86_64"

cat ${home}/Downloads/testing/testing_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/core/core_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/community-testing/community-testing_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/community/community_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/extra/extra_pkg.txt >> ${home}/Downloads/repo.list
cat ${home}/Downloads/multilib/multilib_pkg.txt >> ${home}/Downloads/repo.list

cp -rf ${home}/Downloads/repo.list ${home}/Downloads/latest
mv ${home}/Downloads/repo.list ${home}/Downloads/repo_$(date "+%m-%d-%Y-%H%M").list
rm -rf ${home}/Downloads/testing ${home}/Downloads/core ${home}/Downloads/community-testing ${home}/Downloads/community ${home}/Downloads/extra ${home}/Downloads/multilib
