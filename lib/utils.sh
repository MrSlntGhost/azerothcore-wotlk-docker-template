#!/bin/bash

# Copies SQL files from module directories to the custom SQL directory
copy_module_sql_to_custom() {
    echo "$LINE_LONG"
    echo "Copying SQL files"
    echo "$LINE_LONG"
    
    find "$MODULES_DIR" -type f -name "*.sql" -exec dirname {} \; | sort -u | while read -r sql_dir; do
        module_subdir=$(basename "$sql_dir")
        
        if [[ "$module_subdir" == "updates" || "$module_subdir" == "base" ]]; then
            parent_dir=$(dirname "$sql_dir" | sed 's/-/_/g')
            parent_basename=$(basename "$parent_dir")
            
            if [[ "$parent_basename" == db_* ]]; then
                for sql_file in "$sql_dir"/*.sql; do
                    target_file="$CUSTOM_SQL_DIR/$parent_basename/$module_subdir/$(basename "$sql_file")"
                    mkdir -p "$(dirname "$target_file")"
                    
                    if [ ! -f "$target_file" ]; then
                        cp "$sql_file" "$target_file"
                        echo -e "\033[32mCopying:\033[0m $(basename "$sql_file") to $target_file"
                    else
                        echo -e "\033[34mSkipping:\033[0m File $(basename "$sql_file") already exists in $target_file"
                    fi
                done
            fi
        fi
    done
}

# Updates the AzerothCore main repository
git_update_azerothcore() {
    echo "$LINE_LONG"
    echo "Updating AzerothCore main repository"
    echo "$LINE_LONG"
    echo "Updating repository: azerothcore-wotlk"
    (cd "$ACORE_DIR" && git pull || exit)
}

# Updates all Git repositories in the modules directory
git_update_modules() {
    echo "$LINE_LONG"
    echo "Updating repositories in modules directory"
    echo "$LINE_LONG"
    
    for module_dir in "$MODULES_DIR"/*/; do
        if [ -d "$module_dir/.git" ]; then
            echo "Updating repository: $(basename "$module_dir")"
            (cd "$module_dir" && git pull || exit)
            echo "$LINE_SHORT"
        fi
    done
}