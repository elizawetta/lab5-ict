#!bin/bash
FILES=$(git diff --cached --name-only --diff-filter=ACMR | grep ".txt\$")
# FILES=( $(ls) )
suffix=".txt"

for ((i=0; i<${#FILES[@]}; i++))
do
    if [[ ${#FILES[$i]} -gt 4 ]];
        then 
            if [[ ${FILES[$i]}  == *$suffix ]]; then
                n=0
                while IFS= read -r line; do
                    if [[ $line  == $"# "* ]] && [[ ${#line} -gt 2 ]]; then 
                        n=0
                    elif [[ $line  == $"## "* ]] && [[ ${#line} -gt 3 ]]; then 
                        n=0
                    elif [[ ${#line} == 0 ]] ;then 
                        n=0
                    else
                        echo "Error"
                        echo ${FILES[$i]}
                        exit 1
                    fi
                done < ${FILES[$i]}

            fi
    fi
done

# 1. если строка начинается с "# " или "## "
#   если строка пустая дальше - ошибка
#   если не пустая - ок
# 2. если строка пустая - ок
# 3. если файл пустой - ок 