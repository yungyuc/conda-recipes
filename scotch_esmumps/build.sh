#!/bin/sh
# see http://conda.pydata.org/docs/build.html for hacking instructions.

cd src/
echo 'prefix = $PREFIX' > Makefile.inc
echo '' >> Makefile.inc
if [ `uname` == "Darwin" ]; then
  cp -f $RECIPE_DIR/darwin/Makefile.inc Makefile.inc
else
  cat Make.inc/Makefile.inc.x86-64_pc_linux2 | \
    sed -e "s/= -O3/= -fPIC -O3/" >> \
    Makefile.inc
fi
make esmumps | tee make.log 2>&1
cd ..

# install.
mkdir -p $PREFIX/lib/
cp lib/* $PREFIX/lib/
mkdir -p $PREFIX/bin/
cp bin/* $PREFIX/bin/
mkdir -p $PREFIX/include/
cp include/* $PREFIX/include/

# vim: set ai et nu:
