#!/bin/bash 

# Les Variables
comptoir=0
minuteur=${1-1}
message=${2-"Juvanna, mon cher! Je taime, mon amour!"}

# Les Fonctions
diviser(){
    tableau=()
    groupe=""
    i=0
    if [ "$1" = "debug" ]
    then
        shift
        debug=1
        echo ""
    fi
    while read mot
    do
        if [ $debug ]
        then
            echo "Passo: $i"
            echo "Palavra da vez: $mot"
            echo "Agrupamento: $groupe"
            echo "----"
        fi

        if [ $((${#groupe}+${#mot})) -gt 10 -o -z "${mot}" ]
        then
            tableau+=("$(echo ${groupe} | xargs)")
            groupe="${mot} "
        else
            groupe+="${mot} "
        fi

        i=$((i+1))
    done < <(echo $* | xargs -0 -d ' ' -n 1)
}

jetaime(){
    diviser "${message}"
    banner "${tableau[$1]}"
    sleep ${minuteur} 
    clear
}

# Le Exécution
clear

debug(){
    counter=0
    debugMsg=(
              "Juvanna, mon cher! Je taime, mon amour!" \
              "uma frase muito comprida pode dar problema" \
              "Preludin mora no coracao do Moka"
             )
    
    while [ $counter -lt ${#debugMsg[*]} ]
    do
        diviser "debug" "${debugMsg[${counter}]}"
        echo "[--${tableau[@]}--]"
        echo "[--${#tableau[*]}--]"
        counter=$((counter+1))
    done

    exit
}

#debug

while true
do
    jetaime ${comptoir}
    comptoir=$((comptoir+1))

    if [ "${comptoir}" -ge "${#tableau[*]}" ]
    then
        comptoir=0
    fi
done
