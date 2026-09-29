# This script downloads and extracts data to a specified folder 

# Fail loudly instead of continuing past a failed download or extraction.
set -e

data_folder=data # TODO modify to where you want to store the data

mkdir -p $data_folder
cd $data_folder

echo "> Downloading datasets to $data_folder"

# macOS does not ship wget, so fall back to curl when wget is unavailable.
# -L follows redirects, -C - resumes a partial file.
if command -v wget > /dev/null; then
    fetch() { wget -c "$1"; }
else
    fetch() { curl -L -C - --retry 3 --retry-delay 5 -o "$(basename "$1")" "$1"; }
fi

base=https://web.archive.org/web/20250519023754/http://host.robots.ox.ac.uk/pascal/VOC/voc2007

fetch $base/VOCtrainval_06-Nov-2007.tar
tar -xf VOCtrainval_06-Nov-2007.tar

fetch $base/VOCtest_06-Nov-2007.tar
tar -xf VOCtest_06-Nov-2007.tar
