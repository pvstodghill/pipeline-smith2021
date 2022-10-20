#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Set up
# ------------------------------------------------------------------------

if [ -d ${DATA} ] ; then
    echo 1>&2 "# Removing ${DATA}. Hope that's what you wanted"
    rm -rf ${DATA}
fi

echo 1>&2 "# Initializing ${DATA}/..."
rm -rf ${DATA}/tmp
mkdir -p ${DATA}/tmp

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 ''
echo 1>&2 '# Done.'

