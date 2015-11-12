#!/bin/bash

function usage {
    echo "Usage:"
    echo " $0 -f <packageFilename> -b <buildNumber> [-g <gitRevision>] [-r <projectRootDir>]"
    echo " -f <packageFilename>    file name of the archive that will be created"
    echo " -b <buildNumber>        build number"
    echo " -g <gitRevision>        git revision"
    echo " -r <projectRootDir>     Path to the project dir. Defaults to current working directory."
    echo ""
    exit $1
}

PROJECTROOTDIR=$PWD

########## get argument-values
while getopts 'f:b:g:d:r:' OPTION ; do
case "${OPTION}" in
        f) FILENAME="${OPTARG}";;
        b) BUILD_NUMBER="${OPTARG}";;
        g) GIT_REVISION="${OPTARG}";;
        r) PROJECTROOTDIR="${OPTARG}";;
        \?) echo; usage 1;;
    esac
done

if [ -z ${FILENAME} ] ; then echo "ERROR: No file name given (-f)"; usage 1 ; fi
if [ -z ${BUILD_NUMBER} ] ; then echo "ERROR: No build number given (-b)"; usage 1 ; fi

cd ${PROJECTROOTDIR} || { echo "Changing directory failed"; exit 1; }

if [ ! -f 'composer.json' ] ; then echo "Could not find composer.json"; exit 1 ; fi
if [ ! -f 'bin/composer.phar' ] ; then echo "Could not find composer.phar"; exit 1 ; fi

if type "hhvm" &> /dev/null; then
    PHP_COMMAND=hhvm
    echo "Using HHVM for composer..."
else
    PHP_COMMAND=php
fi

# Run composer
bin/composer.phar install --verbose --no-ansi --no-interaction --prefer-source || { echo "Composer failed"; exit 1; }

# Some basic checks
if [ ! -f 'public_html/index.php' ] ; then echo "Could not find public_html/index.php"; exit 1 ; fi
if [ ! -f 'bin/modman' ] ; then echo "Could not find modman script"; exit 1 ; fi
if [ ! -d '.modman' ] ; then echo "Could not find .modman directory"; exit 1 ; fi
if [ ! -f '.modman/.basedir' ] ; then echo "Could not find .modman/.basedir"; exit 1 ; fi

if [ -d patches ] && [ -f vendor/aoepeople/magento-deployscripts/apply_patches.sh ] ; then
    cd "${PROJECTROOTDIR}/public_html" || { echo "Changing directory failed"; exit 1; }
    bash ../vendor/aoepeople/magento-deployscripts/apply_patches.sh || { echo "Error while applying patches"; exit 1; }
    cd ${PROJECTROOTDIR} || { echo "Changing directory failed"; exit 1; }
fi

# Run modman
# This should be run during installation
# bin/modman deploy-all --force

# Write file: build.txt
echo "${BUILD_NUMBER}" > build.txt

# Write file: version.txt
echo "Build: ${BUILD_NUMBER}" > public_html/version.txt
echo "Build time: `date +%c`" >> public_html/version.txt
if [ ! -z ${GIT_REVISION} ] ; then echo "Revision: ${GIT_REVISION}" >> public_html/version.txt ; fi

# Add maintenance.flag
touch public_html/maintenance.flag

# Create package
if [ ! -d "artifacts/" ] ; then mkdir artifacts/ ; fi

tmpfile=$(tempfile -p build_tar_base_files_)

# Backwards compatibility in case tar_excludes.txt doesn't exist
if [ ! -f "Configuration/tar_excludes.txt" ] ; then
    touch Configuration/tar_excludes.txt
fi

BASEPACKAGE="artifacts/${FILENAME}"
echo "Creating base package '${BASEPACKAGE}'"
tar -vczf "${BASEPACKAGE}" \
    --exclude=./public_html/var \
    --exclude=./public_html/media \
    --exclude=./artifacts \
    --exclude=./tmp \
    --exclude-from="Configuration/tar_excludes.txt" . > $tmpfile || { echo "Creating archive failed"; exit 1; }

EXTRAPACKAGE=${BASEPACKAGE/.tar.gz/.extra.tar.gz}
echo "Creating extra package '${EXTRAPACKAGE}' with the remaining files"
tar -czf "${EXTRAPACKAGE}" \
    --exclude=./public_html/var \
    --exclude=./public_html/media \
    --exclude=./artifacts \
    --exclude-from="$tmpfile" .  || { echo "Creating archive failed"; exit 1; }

cd artifacts
md5sum * > MD5SUMS
