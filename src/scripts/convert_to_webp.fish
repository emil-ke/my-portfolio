#!/usr/bin/env fish

# Check if cwebp is installed
if not type -q cwebp
    echo "cwebp is not installed. Please install it using 'sudo pacman -S libwebp'"
    exit 1
end

# Check if at least one argument (directory path) is provided
if test (count $argv) -eq 0
    echo "Usage: ./convert_to_webp.fish <directory>"
    exit 1
end

# Get the directory path from command-line argument
set directory $argv[1]

# Check if the directory exists
if test -d $directory
    echo "Converting JPG and JPEG files in directory $directory to WebP format..."
else
    echo "Directory $directory not found."
    exit 1
end

# Iterate over JPG and JPEG files in the directory
for file in $directory/*.jpg $directory/*.jpeg
    # Check if there are matching files
    if test -f $file
        # Get the filename without extension
        set filename (basename -s .jpg $file)
        set filename (basename -s .jpeg $filename)

        # (main convert)
        cwebp -q 90 $file -o $directory/$filename.webp

        echo "Converted $file to $directory/$filename.webp"
    else
        echo "No JPG or JPEG files found in directory $directory."
    end
end

# Ask to remove original files
echo "Remove all original files? (y/N)"
set remove_originals (string trim (read))

if test "$remove_originals" = y -o "$remove_originals" = Y
    # Iterate over JPG and JPEG files again and remove them
    for file in $directory/*.jpg $directory/*.jpeg
        if test -f $file
            rm $file
        end
    end
    echo "Files removed"
end
