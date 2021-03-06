# This scripts flattens the file directory
# Run this script with a folder as parameter:
# $ path/to/script path/to/folder

#!/bin/bash

rmEmptyDirs(){
	local DIR="$1"
	for dir in "$DIR"/*/
	do
		[ -d "${dir}" ] || continue # if not a directory, skip
		dir=${dir%*/}
		if [ "$(ls -A "$dir")" ]; then
			rmEmptyDirs "$dir"
		else
			rmdir "$dir"
		fi
	done
}

flattenDir(){
	local DIR="$1"
	find "$DIR" -mindepth 2 -type f -exec mv -i '{}' "$DIR" ';'
}

flattenDir "$1"
rmEmptyDirs "$1"
echo "Done"