#! /bin/sh

export REPO_TAR_URL=https://api.github.com/repos/microsoft/msquic/tarball/ebc124882651f2096a11df0135e5b2de318d5252
export REPO=https://github.com/microsoft/msquic
export SHA=ebc124882651f2096a11df0135e5b2de318d5252
export TARGETARCH=x64

cp /tools/packaging/github-actions/APKBUILD /tools/scripts/alpine-configure-packaging-key.sh /tools/scripts/alpine-packaging-prepare-script.sh .

./alpine-packaging-prepare-script.sh
su packaging -c "abuild-keygen -n"
find /home/packaging/.abuild -name '*.rsa' -exec ./alpine-configure-packaging-key.sh {} \;

mkdir -p /home/packaging/tools/
cp APKBUILD alpine-configure-packaging-key.sh alpine-packaging-prepare-script.sh /home/packaging/tools/
chown -R packaging:abuild /home/packaging/tools/
cd /home/packaging/tools/
su packaging -c "abuild snapshot"
su packaging -c "abuild checksum"
su packaging -c "abuild -r"

/bin/sh