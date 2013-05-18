---------- BEGIN OF SCRIPT
#!/bin/bash
#
#    Fluxus installer for debian squeeze
#
#    Author: Marco Bertocco - http://bquery.com
#    This script is distributed under the terms of GNU General Public Licence v.3
#    The full licence text is available at http://www.gnu.org/licenses/gpl.html
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Latest revision of this script: 18 Apr 2012.
#    If you get errors running this script, please look for workarounds and fixes in the code comments
#
#
#    You MUST run this script as root, as default debian users are not sudoers
#
#
#
#
#
#
BUILD_DIR=$(pwd)

# Remove previous sources of racket
rm racket-5.1.1-src-unix.tgz
rm -r racket-5.1.1
#
# Download and install racket 5.1.11 from sources
# Later versions of racket could work, but I have not tested yet.
# If you can run fluxus building later versions of racket, please let me know.
wget http://download.racket-lang.org/installers/5.1.1/racket/racket-5.1.1-src-unix.tgz
tar -xvf racket-5.1.1-src-unix.tgz
cd $BUILD_DIR/racket-5.1.1/src
mkdir build
cd build

# Configure racket to compile shared libraries and install them under
/usr/local/lib
./configure --prefix=/usr/local --enable-shared
make
make install

#return into the build directory
cd $BUILD_DIR

# Remove previous sources of fluxus
rm -r fluxus
# Download latest fluxus from git [development repository: this is necessary due to the transition from scheme to racket]
# Also this address should work: git://git.sv.gnu.org/fluxus.git
git clone git://git.savannah.nongnu.org/fluxus.git

# Be sure to have all dependencies installed
# Notice that some other packages will be installed as dependencies
# ode
# racket
# fftw
# jack
# libsndfile
# liblo
# glew
# libfreetype
# libasound
# scons
apt-get install libode-dev libfftw3-dev libjack-jackd2-dev libsndfile1-dev
liblo-dev libglew1.5-dev libfreetype6-dev libasound2-dev libopenal-dev
libglut3-dev scons

# Configure and install fluxus
cd $BUILD_DIR/fluxus
scons
scons install

# If you didn't get errors at this point, all the stuff should be installed
# Now you can simply run "fluxus" and have [a lot of] fun.
echo "Please be sure to have the path /usr/local/lib in you ldconfigs"
echo "If you get a \"shared object not found\" error then you should put this line:"
echo "/usr/local/lib"
echo "in a file under /etc/ldconfig.so.conf.d/"
echo "and then run ldconfig as root."
echo ""
echo "Thank you for using this script."
echo "If you would like to contribute, extend or suggest something, feel free to contact me at this mail address:"
echo "info [at] bquery [dot] com"
