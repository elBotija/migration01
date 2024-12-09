#!/bin/bash


# Función para crear un archivo con contenido
create_file() {
    local filename=$1
    local content=$2
    echo "$content" > "$filename"
    git add "$filename"
    git commit -m "Agregando $filename"
}

# Crear commits en master
echo "Creando commits en master..."
create_file "archivo01.js" "console.log('Hola Mundo 1');"
create_file "archivo02.js" "console.log('Hola Mundo 2');"
create_file "archivo03.js" "console.log('Hola Mundo 3');"
create_file "archivo04.js" "console.log('Hola Mundo 4');"

# Crear y trabajar en las ramas feature
for ticket in 101 102 103 104
do
    # Crear y cambiar a la nueva rama
    branch_name="feature/TKT-$ticket"
    git checkout -b "$branch_name" master
    echo "Trabajando en rama $branch_name..."
    
    # Crear 3 commits en cada rama
    for i in {1..3}
    do
        filename="feature${ticket}_archivo${i}.js"
        content="console.log('Feature $ticket - Cambio $i');"
        create_file "$filename" "$content"
    done
    
    # Volver a master para la próxima iteración
    git checkout master
done

echo "¡Proceso completado!"
echo "Se han creado:"
echo "- 4 commits en master"
echo "- 4 ramas feature con 3 commits cada una"
echo ""
echo "Para ver todas las ramas creadas, ejecuta: git branch"
echo "Para ver los commits de una rama, ejecuta: git log <nombre-rama>"
