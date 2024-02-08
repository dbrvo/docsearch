directory="."

# Ensure the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory $directory not found."
    exit 1
fi

# Find files with zero length or consisting only of whitespace characters
no_text_files=()
while IFS= read -r -d '' file; do
    if [ ! -s "$file" ] || [[ $(< "$file" ) =~ ^[[:space:]]*$ ]]; then
        no_text_files+=("$file")
    fi
done < <(find "$directory" -type f -print0)

# Display the found files
if [ ${#no_text_files[@]} -eq 0 ]; then
    echo "No files with no text content found."
else
    echo "Files with no text content found:"
    printf '%s\n' "${no_text_files[@]}"
fi