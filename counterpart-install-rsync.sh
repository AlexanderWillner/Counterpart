#!/usr/bin/env bash

# source: http://librelist.com/browser//homebrew/2011/7/7/rsync/

# Robust shell code ###########################################################
set -o errexit
set -o nounset
set -o pipefail
[[ "${TRACE:-}" ]] && set -x
###############################################################################

# Variables ###################################################################
readonly rsyncPrefix="rsync-"
readonly rsyncVersion="3.0.9"
readonly rsyncSuffix=".tar.gz"
readonly rsyncURL="http://rsync.samba.org/ftp/rsync/src/"
###############################################################################

# Run #########################################################################
echo "Downloading..."
curl -Os "${rsyncURL}${rsyncPrefix}${rsyncVersion}${rsyncSuffix}" || ( echo "couldn't download" >&2; exit 1; )
tar -xzvf "${rsyncPrefix}${rsyncVersion}${rsyncSuffix}"
curl -O "${rsyncURL}${rsyncPrefix}patches-${rsyncVersion}${rsyncSuffix}"
tar -xzvf "${rsyncPrefix}patches-${rsyncVersion}${rsyncSuffix}"
cd "${rsyncPrefix}${rsyncVersion}" || ( echo "folder not found" >&2; exit 1 )

echo "Compiling..."
patch -p1 <patches/fileflags.diff
patch -p1 <patches/crtimes.diff
patch -p1 <patches/hfs-compression.diff
./prepare-source
./configure --prefix /usr/local
make

echo "Installing (as root)..."
sudo make install

echo "Cleanup..."
rm -r "${rsyncPrefix}${rsyncVersion}"
rm "${rsyncPrefix}patches-${rsyncVersion}${rsyncSuffix}"
rm "${rsyncPrefix}${rsyncVersion}${rsyncSuffix}"
###############################################################################
